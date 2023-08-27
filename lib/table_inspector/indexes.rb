
module TableInspector
  class Indexes
    attr_reader :klass, :column_name

    def initialize(klass, column_name = nil, colorize: false)
      @klass = klass
      @column_name = column_name
      @colorize = colorize
    end

    def render
      render_title

      if column_name
        render_indexes_of_column
      else
        render_indexes
      end
    end

    private

    def render_title
      TerminalTable.new do |terminal_table|
        terminal_table.add_row([Text.bold("Indexes")])
      end.render
    end

    def render_indexes_of_column
      TerminalTable.new(headings: headings) do |terminal_table|
        indexes_of_column.each do |index|
          terminal_table.add_row(compose_index_data(index))
        end
      end.render
    end

    def render_indexes
      TerminalTable.new(headings: headings) do |terminal_table|
        indexes.each do |index|
          terminal_table.add_row(compose_index_data(index))
        end
      end.render
    end

    def compose_index_data(index)
      if @colorize
        compose_index_data_with_color(index)
      else
        compose_index_data_without_color(index)
      end
    end

    def compose_index_data_with_color(index)
      index_columns_text = index.columns.join(', ')
      unique_text = index.unique ? "UNIQUE" : ""

      [
        index.name,
        "[#{Text.yellow(index_columns_text)}]",
        unique_text
      ]
    end

    def compose_index_data_without_color(index)
      index_columns_text = index.columns.join(', ')
      unique_text = index.unique ? "UNIQUE" : ""
      [
        index.name,
        "[#{index_columns_text}]",
        unique_text
      ]
    end

    def headings
      %w(Name Columns Unique?)
    end

    def indexes
      @indexes ||= connection.indexes(klass.table_name)
    end

    def indexes_of_column
      indexes.select{ |index| index.columns.include?(column_name.to_s) }
    end

    def connection
      @connection ||= ActiveRecord::Base.connection
    end
  end
end