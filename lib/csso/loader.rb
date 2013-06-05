require 'commonjs'
require 'pathname'

module Csso
  class Loader
    include CallJS

    attr_reader :environment

    class ModifiedEnvironment < CommonJS::Environment
      # CommonJS' require does append .js to modules no matter if it is there already
      def require module_id
        path = module_id.gsub(/^\.\//, "")
        path = path.gsub(/\.js$/, "")
        super path
      end
    end

    def initialize js_path=nil
      default  = Pathname(__FILE__).dirname.join('../../vendor/csso').to_s
      @js_path = js_path || default
      @cxt = V8::Context.new
      @environment = ModifiedEnvironment.new(@cxt, :path => @js_path)

      [Util, Path, Fs].each do |native|
        @environment.native(native.to_s.downcase, native.new)
      end

      [Process, Console].each do|replace|
        @cxt[replace.to_s.downcase] = replace.new
      end
    end

    def require(module_id)
      @environment.require(module_id)
    end

    class Path
      def join(*components)
        File.join(*components)
      end

      def dirname(path)
        File.dirname(path)
      end
    end

    class Util # sys
      def error(*errors)
        raise errors.join(' ')
      end
    end

    class Fs
      def statSync(path)
        File.stat(path)
      end

      def readFile(path, encoding, callback)
        callback.call(nil, File.read(path))
      end
    end

    class Process
      def exit(*args)
      end
    end

    class Console
      def log(*msgs)
        puts msgs.join(',')
      end
    end
  end
end
