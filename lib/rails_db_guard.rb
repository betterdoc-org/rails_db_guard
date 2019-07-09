require "rails_db_guard/version"

module RailsDbGuard
  class Error < StandardError; end

  ENV_NAME_SQL = "SELECT value FROM ar_internal_metadata WHERE key = 'environment'"

  class << self
    def call
      ActiveSupport.on_load(:active_record) do
        adapter = ActiveRecord::Base.configurations[Rails.env]["adapter"]
        require "rails_db_guard/adapters/#{adapter}"
      end
    end

    def guard!(env)
      return unless (ActiveRecord::Base.protected_environments.include?(env) && Rails.env != env)

      raise Error, "You are trying to connect to `#{env}` database from `#{Rails.env}` environment"
    end
  end
end

require "rails_db_guard/railtie"
