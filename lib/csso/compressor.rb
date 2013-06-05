module Csso
  class CssCompressor
    def compress(css)
      require 'csso'
      #TODO: settings?
      Csso.optimize(css, true)
    end

    def self.register!
      if Sprockets.respond_to? :register_compressor
        Sprockets.register_compressor('text/css', COMPRESSOR_SYM, 'Csso::CssCompressor')
      else
        Sprockets::Compressors.register_css_compressor(COMPRESSOR_SYM, 'Csso::CssCompressor', :default => true)
      end
    end
  end
end
