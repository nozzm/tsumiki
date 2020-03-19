module Tsumiki

  # プロパティ名のメソッドを捌いてオブジェクトにする
  class Style
    include StyleProps

    # マルチメディア対応
    module Media
      NONE    = "None"
      SMALL   = "Small"
      MEDIUM  = "Medium"
      LARGE   = "Large"
    end

    @@media_size = {
      Style::Media::NONE   => [],
      Style::Media::SMALL  => ["max-width:480px"],
      Style::Media::MEDIUM => ["min-width:480px", "max-width:1024px"],
      Style::Media::LARGE  => ["min-width:1024px"],
    }

    class << self
      # --- アクセス系
      def useable_in_comopnent
        StyleProps.positioning_props
      end

      def media_size
        @@media_size
      end

      # --- 他
      def create (&block)
        Style.new &block
      end
    end

    attr_reader :style_hash
    # @style_hash の例
    # "None" : {
    #   "none": {
    #     "background-color": "#00f"
    #   },
    #   "hover": {
    #     "background-color": "#000"
    #   }
    # },
    # "Small" : {
    #   "none": {
    #     "background-color": "#fff"
    #   }
    # }

    # @style_hashはNodeにした方が良いと思うが
    # 階層の深さが決まっているのでhashにした
    # NodeにするならStylesInComponentクラスも合わせて考えた方がいい

    def initialize(&block)
      # ノードとかにした方がいい気もする
      @style_hash = {}

      # 最初は作っておく
      @style_hash[Media::NONE] = {}
      @style_hash[Media::NONE][@@no_pseudo_seletor_key] = {}

      if block_given?
        add_with_block &block
      end
    end

    # メソッド名で追加
    def add (name, *args, &block)
      init_keys
      send name, *args, &block
    end

    # ブロックで追加
    def add_with_block (&block)
      init_keys
      instance_eval &block
    end

    # TODO: 足し算
    # def + (other)
    # end

    def empty?
      if @style_hash.length == 1
        return @style_hash[Media::NONE][@@no_pseudo_seletor_key].empty?
      end
      false
    end

    # @style_hashを元にcssな文字列を生成
    def render (base_selector)
      style_text = ""

      @style_hash.each do |media, selector_hash|
        unless media == Media::NONE
          # メディアクエリ
          style_text += "@media screen "
          @@media_size[media].each do |size|
            style_text += "and (#{size}) "
          end
          style_text += "{\n"
        end

        selector_hash.each do |ex_selector, style|
          unless style.empty?
            # (ハッシュが空の可能性がある)
            selector = base_selector

            unless ex_selector == @@no_pseudo_seletor_key
              # 擬似要素や擬似クラスがある
              selector += ":" + ex_selector
            end

            style_text += "#{selector} {\n"
            style.each do |key, value|
              style_text += "  #{key}: #{value};\n"
            end
            style_text += "}\n"
          end
        end

        unless media == Media::NONE
          # メディアクエリを閉じる
          style_text += "}\n"
        end
      end

      style_text
    end

    def == (other)
      @style_hash == other.style_hash
    end

    private

    @@no_pseudo_seletor_key = :none
    @@media_divide_func_name = :screen

    def init_keys
      @pseudo_seletor = @@no_pseudo_seletor_key
      @media_type = Media::NONE
    end

    def method_missing(name, *args, **opt, &block)
      if name == @@media_divide_func_name
        # メディア分割用
        @media_type = args[0]

        unless @style_hash.has_key? @media_type
          # 存在確認、なければ初期化
          @style_hash[@media_type] = {}
          @style_hash[@media_type][@@no_pseudo_seletor_key] = {}
        end

        instance_eval &block
        @media_type = Media::NONE

      elsif styling_props.include? name
        @style_hash[@media_type][@pseudo_seletor][name.to_s.gsub("_", "-")] = args[0]

      elsif selector_event.include? name
        @pseudo_seletor = name.to_s.gsub("_", "-")
        unless @style_hash[@media_type].has_key? @pseudo_seletor
          # 存在確認、なければ初期化
          @style_hash[@media_type][@pseudo_seletor] = {}
        end

        instance_eval &block
        @pseudo_seletor = @@no_pseudo_seletor_key

      elsif selector_event_with_arg.include? name
        # 引数付きセレクタ(仮実装)、呼ばれる可能性が低いので上とまとめない
        @pseudo_seletor = name.to_s.gsub("_", "-") + "(#{args[0].to_s})"
        @style_hash[@media_type][@pseudo_seletor] = {}
        block.call self
        @pseudo_seletor = :none

      else
        super name, *args, **opt, &block
      end
    end
  end
end