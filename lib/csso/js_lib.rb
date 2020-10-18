# frozen_string_literal: true

require 'execjs'

module Csso
  # low-level wrapper around the js lib
  class JsLib
    def initialize(verbose = false)
      if verbose && ExecJS.runtime.is_a?(ExecJS::ExternalRuntime)
        warn "You're using ExecJS::ExternalRuntime, did you forget to add therubyracer or other execjs runtime to gemfile?"
      end

      lib = File.read(File.expand_path("../../#{CSSO_JS_LIB}", File.dirname(__FILE__)))
      raise 'cannot compile or what?' unless (@csso = ExecJS.runtime.compile(lib))
    end

    def compress(css, structural_optimization = true)
      # TODO: raise ArgumentError, "expect css to be a String" unless css.is_a?(String)
      return nil unless css.is_a?(String)

      @csso.call('do_compression', css, structural_optimization)
    end

    def compress_with_sourcemap(css, filename, structural_optimization = true)
      return nil unless css.is_a?(String)

      @csso.call('do_compression_with_map', css, filename, structural_optimization)
    end
  end
end
