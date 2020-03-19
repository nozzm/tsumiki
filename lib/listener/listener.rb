require_relative "state.rb"

module Tsumiki

  class Listener
    attr_writer :page_block

    def initialize (init_state, event_block)
      @actions = {}
      @state = Tsumiki::State.new init_state
      @state.on_update = self.method(:on_update_state)

      @is_creating_actions = true
      instance_exec &event_block if event_block
      @is_creating_actions = false
    end

    def dispatch (action_str)
      instance_eval action_str
    end

    def on_update_state
      @page_block.call @state.h
    end

    private
    
    def method_missing(name, *args, **opt, &block)
      if @is_creating_actions
        # ハッシュ作るフェーズ
        @actions[name] = Proc.new { |*p_args| instance_exec *p_args, &block }
      elsif @actions.has_key? name
        instance_exec *args, &@actions[name]
      else
        super name, *args, **opt, &block
      end
    end

    def state
      @state
    end
  end
  
end