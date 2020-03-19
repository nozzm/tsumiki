require_relative "style_props.rb"
require_relative "style.rb"
require_relative "styles_in_component.rb"

module Tsumiki

  class StyleManager

    @@prefix = "ts"

    class << self
      # --- アクセス系
      def prefix=
        @@prefix
      end
    end

    attr_accessor :styles

    def initialize
      @styles = {}      # 通常のstyle
      @components = {}  # コンポーネントのstyle

      if Config::BUILD_TARGET == Config::BuildTargetType::OPAL
        doc = Native(`document`)

        @style_element = doc.createElement "style"
        @style_element.type = "text/css"

        head = doc.getElementsByTagName("head")[0]
        head.appendChild @style_element
      end
    end

    # @stylesを元にcssを生成してheadに追加
    # 差分検知をした方が良い…
    def update
      # puts @styles

      style_text = ""
      @styles.each do |selector, style|
        style_text += style.render selector
        style_text += "\n"
      end
      @components.each do |component_name, styles_in_comp|
        style_text += styles_in_comp.render to_class_attr_name(component_name)
        style_text += "\n"
      end

      if Config::BUILD_TARGET == Config::BuildTargetType::OPAL
        # 雑に上書き
        @style_element.textContent = style_text
      elsif Config::BUILD_TARGET == Config::BuildTargetType::CRUBY
        puts "--- styles ---"
        puts style_text
      end
    end

    def clear
      @components = {}
    end

    # def add_styles (name, style_proc)
    #   @styles[name] = Style.new &style_proc
    # end

    # return 調査済み, クラス名
    def has_default_style? (component)
      if @components.has_key? to_key component
        if @components[to_key component].default_style
          return true, to_class_attr_name(to_key(component))
        end
        return true, ""
      end

      return false, ""
    end

    def create_default (component, style)
      @components[to_key component] = StylesInComponent.new
      unless style.empty?
        # スタイルがあるなら登録してクラス名を返す
        @components[to_key component].default_style = style
        return to_class_attr_name to_key(component)
      end
      ""
    end

    def create_additional (component, style)
      index = @components[to_key component].add style
      "#{to_class_attr_name to_key(component)}-#{index}"
    end

    private

    def to_key (component)
      component.class.name.split("::")[-1]
    end

    def to_class_attr_name (component_name)
      "#{@@prefix}-#{component_name}"
    end
  end
end