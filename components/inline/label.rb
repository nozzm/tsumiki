module Tsumiki

  class Label < Component
    html_element "p"

    def composition(text: "")
      inner_text text
      insert_children
    end

  end
  
end