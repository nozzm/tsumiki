require_relative "component.rb"
require_relative "component_creator.rb"
require_relative "text.rb"

module Tsumiki

  class Page < Component

    @@event_block = nil
    @@init_state = {}
    @@style_block = nil

    class << self
      def create (**opt, &block)
        # if Config::BUILD_TARGET == Config::BuildTargetType::OPAL
        #   doc = Native(`document`)
        #   str = doc.getElementById(VDomRender.entry_point).textContent
        #   if str
        #     puts str + ";;;;"
        #     @@init_state = instance_eval str
        #     doc.getElementById(VDomRender.entry_point).textContent = ""
        #   end
        # end
        
        listener = Listener.new @@init_state, @@event_block
        page     = Page.new listener, **opt, &block

        # puts Component.Components_func

        # 初期 state でページを作成
        page.listener.on_update_state
      end

      def event (&block)
        @@event_block = block
      end

      def init_state (state)
        @@init_state = state
      end

      def style (&block)
        @@style_block = block
      end

      def entry_point= (a_id)
        VDomRender.entry_point = a_id
      end
    end

    attr_reader :listener, :style_manager

    # listener, option
    def initialize (listener, **opt, &block)
      super()
      @title = opt[:title] || ""
      @block = block

      @vdom_render = VDomRender.new
      @style_manager = StyleManager.new

      @page = self
      @listener = listener
      @listener.page_block = self.method(:create_page)
      @style_manager.styles[:body] = Style.new &@@style_block
    end

    def create_page(new_state)
      # clear all
      reset_children
      @style_manager.clear

      # update state
      change_build_state_to BuildState::COMPOSITION
      instance_exec new_state, &@block
      change_build_state_to BuildState::DONE
      
      # pp self

      # rendering
      do_before_render
      @vdom_render.update self.render
      @style_manager.update
    end

    def do_before_render
      @children.each do |child|
        child.do_before_render
      end
    end

    def render
      h = super
      h[:element] = "root"
      h[:title] = @title
      h
    end

    # --- accessor

    def css (selector, style = nil, &block)
      if style
        @style_manager.styles[selector] = style
      elsif block_given?
        @style_manager.styles[selector] = Style.new &block
      end
    end

  end
end