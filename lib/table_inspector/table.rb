
module TableInspector
  class Table
    attr_reader :klass, :presenter, :presenter_option
    delegate :break_line, :bold, to: TableInspector::Text

    def initialize(klass, presenter_option)
      @klass = klass
      @presenter = Presenter.current.new(klass, presenter_option)
      @presenter_option = presenter_option
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
        terminal_table.add_row([table_name])
      end.render
    end

    def render_body
      TerminalTable.new(headings: presenter.headings) do |terminal_table|
        klass.columns.each do |column|
          terminal_table.add_row(presenter.extract_meta(column).values)
        end
      end.render
    end

    def render_indexes
      Indexes.new(klass, colorize: presenter.option.colorize).render
    end
  end
end