
module TableInspector
  class Presenter
    attr_reader :klass, :sql_type

    def initialize(klass, sql_type:, colorize: false)
      @klass = klass
      @sql_type = sql_type
      @colorize = colorize
    end

    def extract_meta(column)
      if @colorize
        extract_meta_with_highlight(column)
      else
        extract_meta_without_highlight(column)
      end
    end

    def headings
      first_column = klass.columns.first
      extract_meta(first_column).keys.map(&:humanize)
    end

    private

    def extract_meta_with_highlight(column)
      column_data = extract_meta_without_highlight(column)

      # Colorize text but except "comment" field
      column_data.each do |k, v|
        if k != "comment"
          column_data[k] = colorize(v)
        else
          column_data[k]
        end
      end

      column_data.slice(*ordered_keys)
    end

    def extract_meta_without_highlight(column)
      column.as_json.merge(column.sql_type_metadata.as_json).slice(*ordered_keys).tap do |column_data|
        if column_data["default"] == ""
          column_data["default"] = column_data["default"].inspect
        end
      end
    end

    def ordered_keys
      %w[name type limit null default precision scale comment].tap do |keys|
        keys << "sql_type" if sql_type
      end
    end

    def colorize(value)
      case value
      when TrueClass, DateTime, 'datetime'
        Text.green(value)
      when FalseClass
        Text.red(value)
      when Numeric, 'integer', 'decimal'
        Text.blue(value)
      when 'boolean'
        Text.cyan(value)
      when String
        Text.yellow(value)
      else
        value
      end
    end
  end
end
