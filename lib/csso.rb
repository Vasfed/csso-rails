require 'csso/version'
require 'csso/js_lib'
require 'csso/compressor'

module Csso

  def self.js_api
    @csso ||= Csso::JsLib.new
  end

  def self.install(sprockets)
    if sprockets.respond_to? :register_compressor
      sprockets.register_compressor('text/css', :csso, Compressor.new)
      sprockets.css_compressor = :csso
    else
      Sprockets::Compressors.register_css_compressor(:csso, 'Csso::Compressor', :default => true)
    end
  end

  def self.optimize(css, maniac_mode=false, structural_optimization=true)
    if maniac_mode
      maniac_mode = 4 unless maniac_mode.is_a?(Fixnum) && maniac_mode > 0
      begin
        prev_css = css
        css = Optimizer.new.optimize(css, structural_optimization)
        maniac_mode -= 1
      end while maniac_mode > 0 && prev_css != css
      css
    else
      Optimizer.new.optimize(css, structural_optimization)
    end
  end


  class Optimizer
    def optimize(css, structural_optimization=true)
      return nil unless css.is_a?(String)
      return css if css.size <= 3
      Csso.js_api.compress(css, structural_optimization)
    end
  end

end
