require 'execjs'

module Csso
  class JsLib

    def initialize js_path=nil
      if ExecJS.runtime.is_a?(ExecJS::ExternalRuntime)
        warn "You're using ExecJS::ExternalRuntime, did you forget to add therubyracer or other execjs runtime to gemfile?"
      # raise "Need an internal ExecJS runtime, have you included one in your gemfile?"
      end

      default = File.expand_path('../../' + CSSO_JS_LIB_PATH, File.dirname(__FILE__))
      js_path ||= default
      ctx = ExecJS.runtime.compile(File.read(js_path + '/csso.web.js'))
      raise 'cannot compile or what?' unless ctx

      ctx.eval "console = {error: function(){ }, log: function(){} }"
      # ctx.eval <<-EOS
      #   do_compression = function(css, disable_structural){
      #     var compressor = new CSSOCompressor(), translator = new CSSOTranslator();
      #     return translator.translate(
      #       cleanInfo(
      #         compressor.compress(
      #           srcToCSSP(css, 'stylesheet', true),
      #           disable_structural
      #         )
      #       )
      #     );
      #   }
      # EOS
      @csso = ctx
    end

    def compress css, structural_optimization=true
      @csso.call("do_compression", css, !structural_optimization)
    end

  end
end
