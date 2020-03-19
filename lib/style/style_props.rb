module Tsumiki

  module StyleProps

    # https://web-designer.cman.jp/css_ref/function_list/
    # よりパックってきた…
    
    # フォント関連
    @@font = [
      :color,
      :opacity,
      
      :font,
      :font_family,
      :font_feature_settings,
      :font_kerning,
      :font_language_override,
      :font_size,
      :font_size_adjust,
      :font_stretch,
      :font_style,
      :font_synthesis,
      :font_variant,
      :font_variant_alternates,
      :font_variant_caps,
      :font_variant_east_asian,
      :font_variant_ligatures,
      :font_variant_numeric,
      :font_variant_position,
      :font_weight,
    ]

    # テキスト関連
    @@text = [
      :hanging_punctuation,
      :hyphens,
      :letter_spacing,
      :overflow_wrap,
      :tab_size,
      :text_align,
      :text_align_last,
      :text_decoration,
      :text_decoration_line,
      :text_decoration_style,
      :text_decoration_color,
      :text_emphasis,
      :text_emphasis_color,
      :text_emphasis_position,
      :text_emphasis_style,
      :text_indent,
      :text_justify,
      :text_shadow,
      :text_transform,
      :text_underline_position,
      :text_height,
      :vertical_align,
      :white_space,
      :word_break,
      :word_spacing,
      :word_wrap,
      :text_decoration,
      :text_shadow,
      :direction,
      :unicode_bidi,
      :writing_mode,
      :ruby_align,
      :ruby_merge,
      :ruby_position,
    ]

    # 改行、改ページ
    @@break = [
      :break_after,
      :break_before,
      :break_inside,
      :page_break_after,
      :page_break_before,
      :page_break_inside,
    ]

    # リスト
    @@list = [
      :list_style,
      :list_style_image,
      :list_style_position,
      :list_style_type,
    ]

    @@table = [
      :border_collapse,
      :border_spacing,
      :caption_side,
      :empty_cells,
      :table_layout,
    ]

    @@content = [
      :content,
      :counter_increment,
      :counter_reset,
      # :crop,
      # :move_to,
      # :page_policy,
      :quotes,
    ]

    @@print = [
      :orphans,
      :page,
      :page_break_after,
      :page_break_before,
      :page_break_inside,
      :size,
      :widows,
    ]

    @@brend_mode = [
      :background_blend_mode,
      :mix_blend_mode,
    ]

    @@aligiment = [
      :alignment_adjust,
      :alignment_baseline,
      :baseline_shift,
      :bottom,
      :break_after,
      :break_before,
      :break_inside,
      :caption_side,
      :clear,
      :clip,
      :column_count,
      :column_fill,
      :column_gap,
      :column_rule,
      :column_rule_color,
      :column_rule_style,
      :column_rule_width,
      :columns,
      :column_span,
      :column_width,
      :display,
      :dominant_baseline,
      :drop_initial_after_adjust,
      :drop_initial_after_align,
      :drop_initial_before_adjust,
      :drop_initial_before_align,
      :drop_initial_size,
      :drop_initial_value,
      :float,
      :float_offset,
      :hanging_punctuation,
      :height,
      :left,
      :line_height,
      :line_break,
      :line_stacking,
      :line_stacking_ruby,
      :line_stacking_shift,
      :line_stacking_strategy,
      :max_height,
      :max_width,
      :min_height,
      :min_width,
      :orphans,
      :overflow,
      :overflow_style,
      :overflow_x,
      :overflow_y,
      :position,
      :right,
      :ruby_align,
      :ruby_position,
      :size,
      :table_layout,
      :text_align,
      :text_align_last,
      :top,
      :vertical_align,
      :width,
    ]

    @@display = [
      :clear,
      :clip,
      :crop,
      :cursor,
      :display,
      :empty_cells,
      :float,
      :grid_column,
      :grid_row,
      :icon,
      :opacity,
      :outline_color,
      :overflow,
      :overflow_x,
      :overflow_y,
      :presentation_level,
      :quotes,
      :visibility,
      :z_index,

      :inline_box_align,
    ]

    @@layout = [
      :margin,
      :margin_bottom,
      :margin_left,
      :margin_right,
      :margin_top,
      :padding,
      :padding_bottom,
      :padding_left,
      :padding_right,
      :padding_top,
    ]

    @@box_sizing = [
      :box_sizing,
      :height,
      :max_height,
      :max_width,
      :min_height,
      :min_width,
      :width,
    ]

    @@background = [
      :background,
      :background_attachment,
      :background_clip,
      :background_color,
      :background_image,
      :background_origin,
      :background_position,
      :background_repeat,
      :background_size,
    ]

    @@border = [
      :border,
      :border_bottom,
      :border_bottom_color,
      :border_bottom_left_radius,
      :border_bottom_right_radius,
      :border_bottom_style,
      :border_bottom_width,
      :border_collapse,
      :border_color,
      :border_image,
      :border_image_outset,
      :border_image_repeat,
      :border_image_slice,
      :border_image_source,
      :border_image_width,
      :border_left,
      :border_left_color,
      :border_left_style,
      :border_left_width,
      :border_radius,
      :border_right,
      :border_right_color,
      :border_right_style,
      :border_right_width,
      :border_spacing,
      :border_style,
      :border_top,
      :border_top_color,
      :border_top_left_radius,
      :border_top_right_radius,
      :border_top_style,
      :border_top_width,
      :border_width,
      :border_bottom_left_radius,
      :border_bottom_right_radius,
      :border_radius,
      :border_top_left_radius,
      :border_top_right_radius,
      :border_image,
      :border_image_outset,
      :border_image_repeat,
      :border_image_slice,
      :border_image_source,
      :border_image_width,
      :box_shadow,
    ]

    @@outline = [
      :outline,
      :outline_color,
      :outline_style,
      :outline_width,
    ]

    @@clip = [
      :clip,
      :clip_path,
    ]

    @@animation = [
      :animation,
      :animation_delay,
      :animation_direction,
      :animation_duration,
      :animation_fill_mode,
      :animation_iteration_count,
      :animation_name,
      :animation_play_state,
      :animation_timing_function,
      :perspective,
      :perspective_origin,

      :transition,
      :transition_delay,
      :transition_duration,
      :transition_property,
      :transition_timing_function,

      :backface_visibility,
      :perspective,
      :perspective_origin,

      :transform,
      :transform_origin,
      :transform_style,
    ]

    # 段組み
    @@multi_column = [
      :break_after,
      :break_before,
      :break_inside,
      :column_count,
      :column_fill,
      :column_gap,
      :column_rule,
      :column_rule_color,
      :column_rule_style,
      :column_rule_width,
      :columns,
      :column_span,
      :column_width,
    ]

    @@flex = [
      :align_content,
      :align_items,
      :align_self,
      :flex,
      :flex_basis,
      :flex_direction,
      :flex_flow,
      :flex_grow,
      :flex_shrink,
      :flex_wrap,
      :justify_content,
      :order,
    ]

    @@interface = [
      :ime_mode,
      :nav_down,
      :nav_index,
      :nav_left,
      :nav_right,
      :nav_up,
      :resize,
      :text_overflow,

      :pointer_events,
    ]

    @@audio = [
      :cue,
      :cue_after,
      :cue_before,
      :elevation,
      :pause,
      :pause_after,
      :pause_before,
      :pitch,
      :pitch_range,
      :play_during,
      :rest,
      :rest_after,
      :rest_before,
      :richness,
      :speak,
      :speak_as,
      :speak_header,
      :speak_numeral,
      :speak_punctuation,
      :speech_rate,
      :stress,
      :voice_balance,
      :voice_duration,
      :voice_family,
      :voice_pitch,
      :voice_range,
      :voice_rate,
      :voice_stress,
      :voice_volume,
      :volume,
    ]

    @@filter = [
      :filter,
    ]

    @@image = [
      :image_resolution,
      :image_rendering,
      :image_orientation,
      :object_fit,
      :object_position,
    ]

    @@marquee = [
      :marquee_direction,
      :marquee_play_count,
      :marquee_loop,
      :marquee_speed,
      :marquee_style,
    ]

    @@grid = [
      :grid,
      :grid_area,
      :grid_auto_columns,
      :grid_auto_flow,
      :grid_auto_rows,
      :grid_column,
      :grid_column_end,
      :grid_column_start,
      :grid_gap,
      :grid_gap_columns,
      :grid_gap_rows,
      :grid_row,
      :grid_row_end,
      :grid_row_start,
      :grid_template,
      :grid_template_areas,
      :grid_template_columns,
      :grid_template_rows,
    ]

    @@hyper_link = [
      :target,
      :target_name,
      :target_new,
      :target_position,
    ]

    @@bookmark = [
      :bookmark_label,
      :bookmark_level,
      :bookmark_state,
      :bookmark_target,
    ]

    # その他
    # @@other = [
    #   :string_set,

    #   :binding,
    #   :bleed,
    #   :justify_items,
    #   :rotation,
    #   :rotation_point,
    #   :scroll_behavior,
    #   :text_rendering,
    #   :touch_action,
    #   :will_change,
    # ]

    @@all_props = @@font + @@text + @@break + @@list + @@table + @@content + @@print + @@brend_mode + @@aligiment + @@display + @@layout + @@box_sizing + @@background + @@border + @@outline + @@clip + @@animation + @@multi_column + @@flex + @@interface + @@audio + @@filter + @@image + @@marquee + @@grid + @@hyper_link + @@bookmark

    # とりあえず全部返す

    def styling_props
      @@all_props
    end

    def self.positioning_props
      @@layout
    end

    # ---

    # 擬似要素とか擬似クラスとか
    @@selector_event = [
      :link,
      :visited,
      :hover,
      :active,
      :focus,
      :lang,
      :first_child,
      :first_line,
      :first_letter,
      :before,
      :after,
      :root,
      :last_child,
      :first_of_type,
      :last_of_type,
      :only_child,
      :only_of_type,
      :empty,
      :target,
      :enabled,
      :disabled,
      :checked,
    ]

    @@selector_event_with_arg = [
      :nth_child,
      :nth_last_child,
      :nth_of_type,
      :nth_last_of_type,
      :not,
    ]
    
    def selector_event
      @@selector_event
    end

    def selector_event_with_arg
      @@selector_event_with_arg
    end
  end
  
end