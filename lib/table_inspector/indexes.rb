
module TableInspector
  class Indexes
    attr_reader :klass, :column_name

    def initialize(klass, column_name = nil)
      @klass = klass
      @column_name = column_name
    end

    def render
      render_title

      if column_name
        render_indexes_with_specific_column
      else
        render_indexes
      end
    end

    private

    def render_title
      Grid.new do |grid|
        grid.add_row([Text.bold("Indexes")])
      end.render
    end

    def render_indexes_with_specific_column
      Grid.new(headings: headings) do |grid|
        indexes_with_specific_column.each do |index|
          grid.add_row(compose_index_data(index))
        end
      end.render
    end

    def render_indexes
      Grid.new(headings: headings) do |grid|
        indexes.each do |index|
          grid.add_row(compose_index_data(index))
        end
      end.render
    end

    def compose_index_data(index)
      [
        index.name,
        "[#{index.columns.join(', ')}]",
        index.unique ? "UNIQUE" : ""
      ]
    end

    def headings
      %w(Name Columns Unique?)
    end

    def indexes
      @indexes ||= connection.indexes(klass.table_name)
    end

    def indexes_with_specific_column
      indexes.select{|index| index.columns.include?(column_name) }
    end

    def connection
      @connection ||= ActiveRecord::Base.connection
    end
  end
end