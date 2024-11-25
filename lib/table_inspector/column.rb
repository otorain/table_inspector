
module TableInspector
  class Column
    attr_reader :column, :klass, :presenter
    delegate :break_line, :bold, to: TableInspector::Text

    def initialize(klass, column_name, presenter_option)
      @column = klass.columns.find { |column| column.name == column_name.to_s }
      @klass = klass
      @presenter = Presenter.current.new(klass, presenter_option)
    end

    def render
      break_line # empty line
      render_title
      render_body
      break_line # empty line
      render_indexes
      break_line # empty line
    end

    private

    def render_title
      TerminalTable.new do |terminal_table|
        table_name = bold('Table') + ": " + klass.table_name
        column_name = bold('Column') + ": " + column.name
        terminal_table.add_row([table_name, column_name])
      end.render
    end

    def render_body
      TerminalTable.new(headings: presenter.headings) do |terminal_table|
        terminal_table.add_row(@presenter.extract_meta(column).values)
      end.render
    end

    def render_indexes
      Indexes.new(klass, column.name, colorize: presenter.option.colorize).render
    end
  end
end