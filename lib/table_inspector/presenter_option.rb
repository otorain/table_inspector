
module TableInspector
  class PresenterOption
    attr_accessor :sql_type, :comment_only, :colorize

    def initialize(options = {})
      @sql_type = options.fetch(:sql_type, false)
      @comment_only = options.fetch(:comment_only, false)
      @colorize = options.fetch(:colorize, false)
    end
  end
end