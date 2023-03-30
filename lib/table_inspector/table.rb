
module TableInspector
  class Table
    attr_reader :klass, :sql_type, :presenter

    def initialize(klass, sql_type: false, colorize: false)
      @klass = klass
      @sql_type = sql_type
      @presenter = Presenter.new(klass, sql_type: sql_type, colorize: colorize)
    end

    def render
      Text.break_line
      render_title
      render_body
      Text.break_line
      render_indexes
      Text.break_line
    end

    private

    def render_title
      Grid.new do |grid|
        grid.add_row(["#{Text.bold('Table')}: #{klass.table_name}"])
      end.render
    end

    def render_body
      Grid.new(headings: presenter.header) do |grid|
        klass.columns.each do |column|
          grid.add_row(presenter.extract_meta(column).values)
        end
      end.render
    end

    def render_indexes
      Indexes.new(klass).render
    end
  end
end