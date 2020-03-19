module Tsumiki

  class Button < Component
    html_element "button"

    def composition(text: "")
      inner_text text
      insert_children
    end

  end
  
end