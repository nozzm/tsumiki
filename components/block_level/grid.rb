Tsumiki::Component.create ("Grid") {

  # 見た目の定義
  appearance {
    display "grid"
  }

  composition { |row: "", col: ""|
    style {
      grid_template_columns col unless col.empty?
      grid_template_rows row unless row.empty?
    }
    insert_children
  }
}

