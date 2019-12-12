# frozen_string_literal: true

require 'action_controller/railtie'

module Csso
  # hook into rails init
  class Railtie < ::Rails::Railtie
    initializer 'csso.environment', after: 'sprockets.environment' do |app|
      # NB: app.assets may be nil, sprockets-rails creates env in after_initialize
      Csso.install(app.assets)
    end

    # saas-rails-3.2.4(and may be others) sets itself as default, ignoring config? => override :(
    initializer 'csso.setup', after: :setup_compression, group: :all do |app|
      app.config.assets.css_compressor = :csso if app.config.assets.enabled
    end
  end
end
