require 'execjs'

module Csso
  class JsLib

    def initialize
      if ExecJS.runtime.is_a?(ExecJS::ExternalRuntime)
        warn "You're using ExecJS::ExternalRuntime, did you forget to add therubyracer or other execjs runtime to gemfile?"
      end

      lib = File.read(File.expand_path('../../' + CSSO_JS_LIB, File.dirname(__FILE__)))
      unless @csso = ExecJS.runtime.compile(lib)
        raise 'cannot compile or what?'
      end
    end

    def compress css, structural_optimization=true
      @csso.call("do_compression", css, structural_optimization)
    end

    def compress_with_sourcemap css, filename, structural_optimization=true
      @csso.call("do_compression_with_map", css, filename, structural_optimization)
    end

  end
end
