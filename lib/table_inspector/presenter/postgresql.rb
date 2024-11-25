
class TableInspector::Presenter::Postgresql < TableInspector::Presenter
  def extract_meta_without_highlight(column)
    column.as_json.merge(column.sql_type_metadata.as_json).slice(*ordered_keys).tap do |column_data|
      column_data["default"] = case column_data["type"]
                               when "string"
                                 column_data["default"]&.inspect
                               when "boolean"
                                 { "true" => true, "false" => false }[column_data["default"]]
                               else
                                 column_data["default"]
                               end
    end
  end
end