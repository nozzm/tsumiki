module Tsumiki

  # 1つのコンポーネントが持つstyle
  class StylesInComponent
    attr_accessor :default_style

    def initialize
      # コンポーネントが共通で持っているstyle(appearanceに書いてあるやつ)
      @default_style = nil
      # 追加style
      @styles = []
    end

    # スタイルの追加
    def add (style)
      index = @styles.index style
      if index
        # 重複ありなので、そのindexを返す
        index
      else
        # 重複なし
        @styles << style
        @styles.length - 1
      end
    end

    def render (classname_base)
      style_text = ""

      if @default_style
        style_text += default_style.render ".#{classname_base}"
        style_text += "\n"
      end

      @styles.each_with_index do |style, i|
        style_text += style.render ".#{classname_base}-#{i}"
        style_text += "\n"
      end
      
      style_text
    end
  end
end