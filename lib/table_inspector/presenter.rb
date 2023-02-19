
module TableInspector
  class Presenter
    attr_reader :klass, :sql_type

    def initialize(klass, sql_type:)
      @klass = klass
      @sql_type = sql_type
    end

    def extract_meta(column)
      column.as_json.merge(column.sql_type_metadata.as_json).slice(*ordered_keys)
    end

    def header
      first_column = klass.columns.first
      extract_meta(first_column).keys.map(&:humanize)
    end

    private

    def ordered_keys
      %w[name type limit null default precision scale comment].tap do |keys|
        keys << "sql_type" if sql_type
      end
    end
  end
end