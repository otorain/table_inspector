
module TableInspector
  class Column
    attr_reader :column, :klass, :sql_type, :presenter

    def initialize(klass, column_name, sql_type: false, colorize: false )
      @column = klass.columns.find {|column| column.name == column_name.to_s}
      @klass = klass
      @sql_type = sql_type
      @presenter = Presenter.new(klass, sql_type: sql_type, colorize: colorize)
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
      Grid.new do |grid|
        grid.add_row(["#{Text.bold('Table')}: #{klass.table_name}", "#{Text.bold('Column')}: #{column.name}"])
      end.render
    end

    def render_body
      Grid.new(headings: presenter.headings) do |grid|
        grid.add_row(@presenter.extract_meta(column).values)
      end.render
    end
  end
end