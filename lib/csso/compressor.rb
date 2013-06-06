module Csso
  class Compressor
    def compress(css)
      require 'csso'
      #TODO: settings?
      Csso.optimize(css, true)
    end
  end
end
