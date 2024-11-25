
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

    def self.current
      adapter = ApplicationRecord.connection_db_config.adapter.camelize
      available_presenter = %w[Mysql2 Postgresql Sqlite3]

      if available_presenter.include?(adapter)
        "TableInspector::Presenter::#{adapter}".constantize
      else
        TableInspector::Presenter
      end
    end

    private

    def extract_meta_without_highlight(column)
      column.as_json.merge(column.sql_type_metadata.as_json).slice(*ordered_keys).tap do |column_data|
        column_data["default"] = if column_data["type"] == "string"
                                   column_data["default"]&.inspect
                                 else
                                   column_data["default"]
                                 end
      end
    end

    def extract_meta_with_highlight(column)
      column_data = extract_meta_without_highlight(column)

      # Colorize text except comment
      column_data.except("comment").each do |k, v|
        if k == "default"
          column_data[k] = colorize(v, column.type)
        else
          column_data[k] = colorize(v)
        end
      end

      column_data.slice(*ordered_keys)
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

    def colorize(value, type = nil)
      if type
        colorize_by_type(value, type)
      else
        colorize_by_value(value)
      end
    end

    def colorize_by_type(value, type)
      case type
      when :datetime
        green(value)
      when :boolean
        value ? green(value) : red(value)
      when :integer, :decimal
        blue(value)
      when :string, :json, :jsonb
        yellow(value)
      else
        value
      end
    end

    def colorize_by_value(value)
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
