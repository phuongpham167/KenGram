require_relative "boot"
require "rails/all"
require "carrierwave"
require "carrierwave/orm/activerecord"
Bundler.require(*Rails.groups)

module KenGram
  class Application < Rails::Application
    config.load_defaults 5.1
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
