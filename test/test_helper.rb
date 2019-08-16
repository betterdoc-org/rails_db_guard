$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

ENV["RAILS_ENV"] = "test"

require "rails_app/config/environment"
# require "rails/test_help"

require "minitest/autorun"
require "climate_control"

