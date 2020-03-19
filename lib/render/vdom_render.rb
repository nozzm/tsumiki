module Tsumiki

  # virtual-dom 変換機 (仮)
  # ツリーの例)
  # {
  #   :element=>"root", 
  #   :children=>
  #   [
  #     {:element=>"p", :attributes=>{}, :children=>["hello world"]}
  #   ], 
  #   :title=>""
  # }
  class VDomRender
    include Event
    @@entry_point = "app"

    def self.entry_point= (a_id)
      @@entry_point = a_id
    end

    def self.entry_point
      @@entry_point
    end

    def initialize
      @first_time = true # 初回呼び出し(差分検知を実装できたら消す)

      if Config::BUILD_TARGET == Config::BuildTargetType::OPAL
        @doc = Native(`document`)
        @win = Native(`window`)
      end
    end

    def update(dom_tree)
      if Config::BUILD_TARGET == Config::BuildTargetType::CRUBY
        # CRuby ならツリー表示のみ (デバッグ出力は仮)
        pp dom_tree
        return
      end

      # puts dom_tree
      @app_root = @doc.getElementById(@@entry_point)

      if !@app_root
        puts "no entry point!"
        return
      end

      if @first_time
        @doc.title = dom_tree[:title]
        @first_time = false
      end

      # TODO: 差分検出とか
      # (参考 https://kuroeveryday.blogspot.com/2018/11/how-to-create-virtual-dom-framework.html)

      # 雑に全部削除
      @doc.getElementById(@@entry_point).textContent = `null`
      
      # 雑に全部生成
      dom_tree[:children].each do |child|
        @app_root.appendChild create_node child
      end
    end

    private

    # ノードを作る
    def create_node(node)
      if node.instance_of? String
        # 文字列ならそのまま表示する
        return @doc.createTextNode node.to_s
      end

      elem = @doc.createElement node[:element]

      # 属性の処理
      node[:attributes].each do |key, val|
        if event_attribute? key
          if key == "onclick"
            # 多分on_clickが一番多いので先に処理してwindow_eventの確認をしない
            elem.addEventListener key.sub("on", ""), ->(event){ val.call }
          elsif window_event? key
            # windowに投げる(雑)
            @win.addEventListener key.sub("on", ""), ->(event){
              val.call 
            }
          else
            elem.addEventListener key.sub("on", ""), ->(event){ val.call }
          end
        else
          elem.setAttribute key, val
        end
      end

      # クラスの処理
      node[:class_list].each do |class_name|
        elem.classList.add class_name
      end

      # 子要素の処理
      node[:children].each do |child|
        elem.appendChild create_node child
      end
      
      elem
    end

    def event_attribute?(attr_name)
      attr_name.start_with? "on"
    end

  end
  
end