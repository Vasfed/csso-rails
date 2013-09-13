#encofing: utf-8

require 'optparse'

module Csso
  module CLI
    def self.run!(argv=ARGV)
      maniac = false
      opts = OptionParser.new do |opts|
        opts.version = Csso::VERSION
        opts.banner = "CSS Optimizer (ruby bindings by vasfed) version #{opts.version}"
        opts.separator ""
        opts.separator "Usage:"
        opts.separator "  #{opts.program_name} [options] FILE [FILE2 [FILE3 [...]]"
        opts.separator "  #{opts.program_name} [options] < some_file.css"
        opts.separator ""
        opts.separator "All input files are concatenated and fed to stdout after processing."
        opts.separator ""

        opts.separator "Options:"
        opts.on("-m", "--[no-]maniac", "\"Maniac mode\" optimizes input multiple times until optimization stops to give any results.") do |v|
          maniac = v
        end

        opts.on_tail("-v", "--version", "Print version information") do
          return puts opts.ver
        end
        opts.on_tail("-h", "--help", "Show this message") do
          return puts opts.help
        end
      end

      opts.parse!(argv)

      if $stdin.tty? && argv.empty?
        return puts opts.help
      end

      ARGV.replace(argv)
      css = ARGF.read
      puts Csso.optimize(css, maniac)
    end
  end
end
