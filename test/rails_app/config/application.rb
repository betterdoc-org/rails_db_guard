# frozen_string_literal: true

require File.expand_path("boot", __dir__)

require "active_record/railtie"

Bundler.require(*Rails.groups)
require "rails_db_guard"

module RailsApp
  class Application < Rails::Application
    # config.autoload_paths += ["#{config.root}/app/models/*.rb"]
    config.eager_load = false
    config.active_record.sqlite3.represent_boolean_as_integer = true
    config.root = File.expand_path("..", __dir__)
  end
end
