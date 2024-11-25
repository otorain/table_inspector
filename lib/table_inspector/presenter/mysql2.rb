class TableInspector::Presenter::Mysql2 < TableInspector::Presenter
  def extract_meta_without_highlight(column)
    column.as_json.merge(column.sql_type_metadata.as_json).slice(*ordered_keys).tap do |column_data|
      column_data["default"] = case column_data["type"]
                               when "string"
                                 column_data["default"]&.inspect
                               when "boolean"
                                 { "1" => true, "0" => false }[column_data["default"]]
                               else
                                 column_data["default"]
                               end
    end
  end
end