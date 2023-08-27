
module TableInspector
  class TerminalTable
    attr_reader :terminal_table

    delegate :add_row,
             :to_s,
             :rows, to: :terminal_table

    def initialize(**options, &block)
      @terminal_table = ::Terminal::Table.new(**options)
      style = TableInspector.style || { border: :ascii }
      @terminal_table.style = style
      yield self if block_given?
    end

    def render
      if rows.empty?
        Text.break_line
        puts " Empty."
      else
        puts self
      end
    end
  end
end
