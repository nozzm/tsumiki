module Tsumiki

  class Image < Component
    html_element "img"

    # 見た目を定義
    def appearance
    end
    
    # 構造を定義
    def composition
      insert_children
    end

    def src (image)
      @attributes[:src] = image
      # 画像名を自動で定義
      @attributes[:alt] = image.split("/")[-1].split(".")[0]
      self
    end
  end
  
end