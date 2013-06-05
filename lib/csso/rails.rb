require "action_controller/railtie"

module Csso

  COMPRESSOR_SYM = :csso

  class Railtie < ::Rails::Railtie
    initializer "csso.environment", :after => "sprockets.environment" do
      CssCompressor.register!
    end

    # saas-rails-3.2.4(and may be others) sets itself as default, ignoring config? => override :(
    initializer "csso.setup", :after => :setup_compression, :group => :all do|app|
      if app.config.assets.enabled && (!app.config.assets.css_compressor.respond_to?(:to_sym))
        app.config.assets.css_compressor = :csso
      end
    end

  end

end
