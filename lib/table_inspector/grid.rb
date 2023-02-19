
module TableInspector
  class Grid
    attr_reader :grid

    def initialize(**options)
      @grid = TTY::Table.new(**options)
    end

    def render(**with)
      yield grid
      puts grid.render(**common_render_options.merge(with))
    end

    def render_ascii(**with)
      yield grid
      puts grid.render(:ascii, **common_render_options.merge(with))
    end

    def common_render_options
      {
        multiline: true
      }
    end
  end
end