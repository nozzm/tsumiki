module Tsumiki

  class Component
    include Event

    attr_accessor :page
    # attr_reader :attributes

    # --- class method

    @@components_func = {}

    class << self
      # --- 旧仕様互換のため残す
      def inherited(child)
        # 無名クラスは飛ばす
        return unless child.name

        # クラス名とコンポーネント名を登録
        component_name = child.to_s.split("::")[-1]
        @@components_func[to_method_name(component_name)] = child.to_s

        # クラス変数を追加
        # html_element でhtmlの要素を指定可能にする
        if Config::BUILD_TARGET == Config::BuildTargetType::CRUBY
          str = <<-EOS
          #{child.to_s}.class_eval {
            def self.html_element (element_name)
              class_eval \"def html_element_name() \'\" + element_name + \"\' end\"
            end
          }
          EOS
          instance_eval str
        else
          # Opalは↑の方法だとパースエラー(こっちの方法はCRubyだと改行が無いのでエラー)
          str = "#{child.to_s}.class_eval {
            def self.html_element (element_name)
              class_eval "
          str += "\"def html_element_name() \'\" + element_name + \"\' end\""
          str += "
            end
          }"
          instance_eval str
        end
      end

      def to_method_name(str)
        str
        .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .tr("-", "_")
        .downcase
      end

      # コンポーネント作成用
      def create(name, &block)
        Component::Creator.new name, &block
      end

      def components_func
        @@components_func
      end
    end

    # オーバーライド用クラスメソッド
    ["attributes", "appearance", "composition", "before_render"].each do |method_name|
      instance_eval <<-EOS
      def self.#{method_name}_block=(val)
        @#{method_name}_block = val
      end

      def self.#{method_name}_block
        @#{method_name}_block
      end
      EOS
    end

    module BuildState
      NONE        = 0
      ATTRIBUTE   = 1
      APPEARANCE  = 2
      COMPOSITION = 3
      DONE        = 4
    end


    # --- core

    def initialize
      @children = []
      @class_attr = [] # DOMのクラス属性
      @id_attr = ""    # DOMのid属性
      @attributes = {}    # その他属性
      @build_state = BuildState::NONE
    end

    def html_element_name
      "div"
    end

    # ハッシュを登録
    def render
      h = {}
      h[:element] = html_element_name
      h[:class_list] = @class_attr
      
      # 属性の定義
      h[:attributes] = {}
      h[:attributes][:id] = @id_attr unless @id_attr.empty?
      if @event
        @event.each do |k, v|
          event_name = k.to_s.gsub(/_/, "")
          h[:attributes][event_name] = Proc.new { @page.listener.dispatch v }
        end
      end
      if @attributes
        @attributes.each do |k, v|
          attr_name = k.to_s.gsub(/_/, "-")
          h[:attributes][attr_name] = v
        end
      end

      h[:children] = []
      @children.each do |child|
        h[:children].push child.render
      end

      h
    end

    # 子に追加
    def add_child(component)
      @children << component
    end

    # 子を全部消す
    def reset_children
      @children = []
    end

    # --- 構成記述用

    # テキストの記述
    def inner_text(str)
      add_child Text.new str
    end

    # 子要素を実行
    def insert_children
      self.instance_exec &@block if @block
    end

    # --- オーバーライド系

    # 属性の定義
    def attributes
    end

    # 見た目を記述
    def appearance
    end
    
    # 構成を記述
    def composition(**param)
      insert_children
    end

    # レンダリング直前に呼ばれる
    def before_render
    end

    # --- getter, setter
    # メソッドチェーン用

    # DOMのクラス属性に値を追加
    def html_class (*args)
      @class_attr += args
      self
    end

    # DOMのクラス属性に値を追加
    def id (a_id)
      @id_attr += a_id
      self
    end

    # その他属性の追加
    def html_attr (**h)
      h.each do |k, v|
        @attributes[k] = v
      end
      self
    end

    # スタイル追加
    def style (&block)
      @temp_style.add_with_block &block
      self
    end

    # Styleオブジェクトを追加
    # TODO: Styleの足し算の実装
    # def add_style (style)
    #   @temp_style += style
    #   self
    # end

    # 関数化できるプロパティ
    @@usable_style_props = Style.useable_in_comopnent

    # 共通な引数の処理をする
    def register(**opt, &block)
      @event = get_js_event(opt)
      @composition_args = opt.delete_if { |k, v| @event.include? k }
      @block = block
    end

    # ここで実際に要素を作る
    def build
      # 属性の定義
      change_build_state_to BuildState::ATTRIBUTE
      attributes

      # 見た目の処理
      change_build_state_to BuildState::APPEARANCE
      has_default, name = page.style_manager.has_default_style? self
      if has_default
        # 名前があるなら追加
        html_class name unless name.empty?
      else
        # デフォルトがない = コンポーネントが初めて呼ばれた
        # TODO: 場所をdefine_methodのところに移したいけど無理そう
        @temp_style = Style.new
        appearance
        classname = page.style_manager.create_default self, @temp_style
        html_class classname unless classname.empty?
      end
      @temp_style = Style.new # 追加style用に初期化
      
      # 構成の処理
      change_build_state_to BuildState::COMPOSITION
      unless @composition_args.empty?
        composition @composition_args
      else
        composition
      end

      change_build_state_to BuildState::DONE
    end

    def do_before_render
      before_render
      build_add_style_props
      @children.each do |child|
        child.do_before_render 
      end
    end

    private

    def method_missing(name, *args, **opt, &block)
      if @build_state == BuildState::ATTRIBUTE
        # 属性追加
        @attributes[name] = args[0]

      elsif @build_state == BuildState::APPEARANCE
        # 見た目を定義するフェーズの時はstyleに処理を投げる
        @temp_style.add name, *args, &block

      elsif @build_state == BuildState::COMPOSITION
        # 構成フェーズ 
        
        if @@components_func.has_key?(name.to_s)
          # コンポーネントが定義されている
          class_name = @@components_func[name.to_s]
          Component.class_eval do
            # creatorとかの方が早そうなのでもしかして移動した方がいいかも。。。
            define_method name do |*args, **opt, &block|
              component = self.instance_eval "#{class_name}.new"   # コンポーネントの作成
              component.page = self.page                           # ルートになっているページコンポーネントを代入
              component.register opt, &block                       # 引数の登録
              component.build                                      # コンポーネントの組み立て
              self.add_child component                             # 子に追加
              component                                            # 最後は自分を返す
            end
          end
          # 1回目の関数を実行
          send name, *args, **opt, &block
        else
          super name, *args
        end

      elsif @build_state == BuildState::DONE
        # メソッドチェーンなどで呼ばれる関数

        if @@usable_style_props.include? name
          # スタイルの定義
          @temp_style.add name, *args, &block
        else
          # スタイルでなければ属性に突っ込む
          # FIXME:属性かチェックして属性じゃなければsuperに飛ばす
          @attributes[name] = args[0]
        end

        self
      end
    end

    def change_build_state_to (state)
      @build_state = state
    end

    # 追加されたstyleを処理
    def build_add_style_props
      unless @temp_style.empty?
        classname = page.style_manager.create_additional self, @temp_style
        html_class classname
      end
    end
  end
end
