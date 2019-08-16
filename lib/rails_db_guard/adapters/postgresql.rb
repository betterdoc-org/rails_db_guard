# frozen_string_literal: true

ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.set_callback :checkout, :after do
  env = raw_connection.exec(RailsDbGuard::ENV_NAME_SQL).values.flatten.first
  RailsDbGuard.guard!(env)
rescue PG::UndefinedTable => e
  raise e unless e.message =~ /relation \"ar_internal_metadata\" does not exist/
end
