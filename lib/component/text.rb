module Tsumiki

  # 生の文字列が出せる特別な存在
  class Text
    def initialize(text)
      @text = text.to_s
    end

    def render
      @text
    end

    # コンポーネントを継承していないので
    def do_before_render
    end
  end
  
end