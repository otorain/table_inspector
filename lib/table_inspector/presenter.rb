
module TableInspector
  class Presenter
    attr_reader :klass, :option
    delegate :green, :yellow, :red, :blue, :cyan, to: Text

    def initialize(klass, option)
      @klass = klass
      @option = option
    end

    def extract_meta(column)
      if option.colorize
        extract_meta_with_highlight(column)
      else
        extract_meta_without_highlight(column)
      end
    end

    def headings
      ordered_keys.map(&:humanize)
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
      if option.comment_only
        %w[name comment]
      else
        %w[name type limit null default precision scale comment].tap do |keys|
          keys << "sql_type" if option.sql_type
        end
      end
    end

    def colorize(value)
      case value
      when TrueClass, DateTime, 'datetime'
        green(value)
      when FalseClass
        red(value)
      when Numeric, 'integer', 'decimal'
        blue(value)
      when 'boolean'
        cyan(value)
      when String
        yellow(value)
      else
        value
      end
    end
  end
end
