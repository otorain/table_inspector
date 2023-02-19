
module TableInspector
  module Text
    extend self

    def bold(text)
      "\033[1m#{text}\033[0m"
    end

    def break_line
      puts "\n"
    end
  end
end