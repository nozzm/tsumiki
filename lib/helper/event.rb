module Tsumiki

  module Event
    
    @@element_events = [
      :on_abort,
      :on_blur,
      :on_canplay,
      :on_canplaythrough,
      :on_changez,
      :on_click,
      :on_cuechange,
      :on_dbclick,
      :on_durationchange,
      :on_emptied,
      :on_ended,
      :on_error,
      :on_focus,
      :on_input,
      :on_invalid,
      :on_keydown,
      :on_keypress,
      :on_keyup,
      :on_loadeddata,
      :on_loadedmetadata,
      :on_loadstart,
      :on_mousedown,
      :on_mouseenter,
      :on_mouseleave,
      :on_mousemove,
      :on_mouseout,
      :on_mouseover,
      :on_mouseup,
      :on_mousewheel,
      :on_pause,
      :on_play,
      :on_playing,
      :on_progress,
      :on_ratechange,
      :on_reset,
      :on_scroll,
      :on_seeked,
      :on_seeking,
      :on_select,
      :on_stalled,
      :on_submit,
      :on_suspend,
      :on_timeupdate,
      :on_unload,
      :on_volumechange,
      :on_waiting
    ]

    # wiwndowで発生するやつ(登録する時windowに入れる)
    @@window_events = [
      :on_afterprint,
      :on_beforeprint,
      :on_beforeunload,
      :on_cancel,
      :on_hashchange,
      :on_load,
      :on_message,
      :on_offline,
      :on_online,
      :on_pagehide,
      :on_pageshow,
      :on_popstate,
      :on_resize,
      :on_show,
      :on_storage,
    ]

    @@js_events = @@element_events + @@window_events

    def get_js_event(opt)
      # 空なら空を返す
      {} unless opt

      events = {}
      opt.each do |k, v|
        if @@js_events.include? k
          # jsイベントにある
          events[k] = v
        end
      end
      events
    end

    def window_event? (name)
      @@window_events.include? name.sub(/on/, "on_")
    end

  end
end