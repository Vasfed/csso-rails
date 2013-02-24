require "action_controller/railtie"

module Csso

  COMPRESSOR_SYM = :csso

  class Railtie < ::Rails::Railtie
    initializer "csso.environment", :after => "sprockets.environment" do
      CssCompressor.register
    end

    # saas-rails-3.2.4(and may be others) sets itself as default, ignoring config? => override :(
    initializer "csso.setup", :after => :setup_compression, :group => :all do|app|
      if app.config.assets.enabled && (!app.config.assets.css_compressor.respond_to?(:to_sym))
        app.config.assets.css_compressor = :csso
      end
    end

  end

  class CssCompressor
    def compress(css)
      require 'csso'
      #TODO: settings?
      Csso.optimize(css, true)
    end

    def self.register
      if Sprockets.respond_to? :register_compressor
        Sprockets.register_compressor('text/css', COMPRESSOR_SYM, 'Csso::CssCompressor')
      else
        Sprockets::Compressors.register_css_compressor(COMPRESSOR_SYM, 'Csso::CssCompressor', :default => true)
      end
    end
  end

end
