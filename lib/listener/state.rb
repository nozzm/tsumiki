module Tsumiki

  class State
    attr_writer :on_update

    def initialize (init_state)
      @h = init_state
    end

    def []= (key, val)
      @h[key] = val
      @on_update.call if @on_update
    end

    def [] (key)
      @h[key]
    end

    def h
      # FIXME: 浅いコピー
      @h.dup
    end
  end
  
end