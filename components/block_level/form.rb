module Tsumiki

  class Form < Component
    html_element "form"

    # 見た目を定義
    def appearance
    end
    
    # 構造を定義
    def composition
      insert_children
    end
  end
  
end