module Tsumiki

  # メソッドチェーンでtype指定
  class FormComponent < Component
    html_element "input"
  end

  # datetime-localは知らん
  input_types = [
    "Text",   "Password", "Tel",    "Url",   "Email", "Search",
    "Date",   "Month",    "Week",   "Time", 
    "Number", "Range",    "Color",  "Radio", "Checkbox",
    "File",   "Hidden",   "Submit", "Image", "Reset", "Button",
  ]

  # FIXME: なんかエラー
  # FormHogeコンポーネントを定義
  # input_types.each do |type|
  #   instance_eval <<-EOS
  #   class Form#{type} < FormComponent
  #     def attributes
  #       type \'#{type.downcase}\'
  #     end
  #   end
  #   EOS
  # end

end