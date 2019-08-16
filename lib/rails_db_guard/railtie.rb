# frozen_string_literal: true

module RailsDbGuard
  # :nodoc:
  class Railtie < Rails::Railtie
    config.to_prepare do
      RailsDbGuard.call
    end
  end
end
