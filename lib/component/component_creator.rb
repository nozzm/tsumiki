module Tsumiki

  class Component

    # コンポーネント作成用クラス
    class Creator
      def initialize (name, &block)
        @component_name   = name
        @extend           = nil # 継承先
        @html_element     = ""  # HTML属性
        @blocks           = {}  # オーバーライド用
        @original_methods = {} # 自作メソッド

        @is_createing = true
        instance_eval &block
        @is_createing = false

        create_class
      end

      def create_class
        # クラス作成
        if @extend
          # 継承あり
          Tsumiki.const_set @component_name, Class.new(instance_eval "Tsumiki::#{@extend}")
        else
          Tsumiki.const_set @component_name, Class.new(Tsumiki::Component)
        end

        # 関数定義
        component_name = "Tsumiki::#{@component_name}"
        target = instance_eval component_name

        # 要素名継承用関数
        unless @html_element.empty?
          # バックスラッシュはOpal用
          str = <<-EOS
          def html_element_name
            \"#{@html_element}\"
          end
          EOS
          target.class_eval str
        end

        # オーバーライド系
        @blocks.each do |method_name, v|
          # Procを代入
          target.send "#{method_name}_block=", v
          str = ""
          if method_name == "composition"
            # 引数あり、super実行なしなので別に定義

            # (instance_execは必須)
            str = <<-EOS
            def #{method_name}(**param)
              instance_exec param, &(#{component_name}.#{method_name}_block)
            end
            EOS

          else
            # (instance_execは必須)
            str = <<-EOS
            def #{method_name}
              super()
              instance_exec &(#{component_name}.#{method_name}_block)
            end
            EOS
          end
          target.class_eval str
        end

        # 自作メソッド集
        @original_methods.each do |method_name, block|
          target.class_eval {
            define_method method_name, &block
          }
        end

        # クラス名とコンポーネント名を登録
        Component.components_func[Component.to_method_name(@component_name)] = target.name
      end

      private

      def method_missing(name, *args, **opt, &block)
        if @is_createing
          # 自作のメソッド
          @original_methods[name] = block
        else
          super name, *args, **opt, &block
        end
      end

      def extend (name)
        @extend = name
      end
      def html_element (name)
        @html_element = name
      end

      def attributes (&block)
        @blocks["attributes"] = block
      end
      def appearance (&block)
        @blocks["appearance"] = block
      end
      def composition (&block)
        @blocks["composition"] = block
      end
      def before_render (&block)
        @blocks["before_render"] = block
      end
    end
  end
  
end