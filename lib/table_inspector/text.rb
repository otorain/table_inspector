
module TableInspector
  module Text
    extend self

    def bold(text)
      "\033[1m#{text}\033[0m"
    end

    def break_line
      puts "\n"
    end
    
    def red(text)
      "\e[31m#{text}\e[0m"
    end

    def green(text)
      "\e[32m#{text}\e[0m"
    end
    
    def yellow(text)
      "\e[33m#{text}\e[0m"
    end
    
    def blue(text)
      "\e[34m#{text}\e[0m"
    end

    def cyan(text)
      "\e[36m#{text}\e[0m"
    end
  end
end
