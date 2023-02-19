
module TableInspector
  class Column
    attr_reader :column, :klass, :sql_type, :presenter

    def initialize(klass, column_name, sql_type: false)
      @column = klass.columns.find {|column| column.name == column_name.to_s}
      raise_column_not_found_error! unless @column
      @klass = klass
      @sql_type = sql_type
      @presenter = Presenter.new(klass, sql_type: sql_type)
    end

    def render
      Text.break_line

      render_title
      render_body

      Text.break_line

      Indexes.new(klass, column.name).render

      Text.break_line
    end

    private

    def render_title
      Grid.new.render padding: [0, 2] do |grid|
        grid << ["#{Text.bold('Table')}: #{klass.table_name}", "#{Text.bold('Column')}: #{column.name}"]
      end
    end

    def render_body
      Grid.new(header: presenter.header).render_ascii do |grid|
        grid << @presenter.extract_meta(column).values
      end
    end

    def raise_column_not_found_error!
      raise TableInspector::Error, "Column not found!"
    end
  end
end