# frozen_string_literal: true

class RailsDbGuard::Railtie < Rails::Railtie
  config.to_prepare do
    RailsDbGuard.call
  end
end
