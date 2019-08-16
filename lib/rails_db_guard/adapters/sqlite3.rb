# frozen_string_literal: true

ActiveRecord::ConnectionAdapters::SQLite3Adapter.set_callback :checkout, :after do
  env = raw_connection.execute(RailsDbGuard::ENV_NAME_SQL).first["value"]
  RailsDbGuard.guard!(env)
rescue SQLite3::SQLException => e
  raise e unless e.message =~ /no such table\: ar_internal_metadata/
end
