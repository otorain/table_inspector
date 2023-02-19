
module TableInspector
  class Indexes
    attr_reader :klass, :column

    def initialize(klass, column = nil)
      @klass = klass
      @column = column
    end

    def render
      render_title

      if column
        render_indexes_with_specific_column
      else
        render_indexes
      end
    end

    private

    def render_title
      Grid.new.render padding: [0, 2] do |grid|
        grid << [Text.bold("Indexes")]
      end
    end

    def render_indexes_with_specific_column
      if indexes_with_specific_column.blank?
        puts "Empty."
        return
      end

      Grid.new.render do |grid|
        indexes_with_specific_column.each do |index|
          grid << compose_index_data(index)
        end
      end
    end

    def render_indexes
      if indexes.blank?
        puts "Empty."
        return
      end

      Grid.new.render do |grid|
        indexes.each do |index|
          grid << compose_index_data(index)
        end
      end
    end

    def compose_index_data(index)
      [
        index.name,
        "[#{index.columns.join(', ')}]",
        index.unique ? "UNIQUE" : ""
      ]
    end

    def indexes
      @indexes ||= connection.indexes(klass.table_name)
    end

    def indexes_with_specific_column
      indexes.select{|index| index.columns.include?(column) }
    end

    def connection
      @connection ||= ActiveRecord::Base.connection
    end
  end
end