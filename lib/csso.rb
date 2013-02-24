require 'v8'
require 'csso/version'
require 'csso/utils'
require 'csso/loader'

module Csso

  @loader = Csso::Loader.new
  @csso = @loader.require('cssoapi')

  def self.js_api
    @csso
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
    include CallJS

    def optimize(css, structural_optimization=true)
      return nil unless css.is_a?(String)
      return css if css.size <= 3
      calljs do
        Csso.js_api['justDoIt'].call(css, !structural_optimization)
      end
    end
  end

end
