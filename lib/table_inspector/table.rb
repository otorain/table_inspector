
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

      Indexes.new(klass).render

      Text.break_line
    end

    private

    def render_title
      Grid.new.render do |grid|
        grid << ["#{Text.bold('Table')}: #{klass.table_name}"]
      end
    end

    def render_body
      Grid.new(header: presenter.header).render_ascii(indent: 2) do |grid|
        klass.columns.each do |column|
          grid << presenter.extract_meta(column).values
        end
      end
    end
  end
end