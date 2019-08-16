# frozen_string_literal: true

require "test_helper"

class RailsDbGuardTest < Minitest::Test
  def setup
    # To be able to test that "hook" is run every time for each test we need new connection for each test.
    # That is why we remove connection before each test and manually create new connection for each test
    ActiveRecord::Base.remove_connection
  end

  def test_that_it_has_a_version_number
    refute_nil ::RailsDbGuard::VERSION
  end

  def test_it_does_not_raise_error_if_trying_to_connect_to_current_environment_database
    connect_to(:test)
    assert Foo.count
  end

  def test_it_raises_error_if_trying_to_connect_to_other_protected_environment_database
    assert ActiveRecord::Base.protected_environments.include?("production")
    assert_raises RailsDbGuard::Error do
      connect_to(:production)
      Foo.count
    end
  end

  def test_it_does_not_raise_error_if_trying_to_connect_to_other_environment_database_that_is_not_protected
    refute ActiveRecord::Base.protected_environments.include?("development")
    connect_to(:development)
    assert Foo.count
  end

  def test_it_does_not_raise_error_if_trying_to_connect_to_current_environment_if_it_is_protected
    assert ActiveRecord::Base.protected_environments.include?("production")
    Rails.stub("env", "production") do
      connect_to(:production)
      assert Foo.count
    end
  end

  def test_it_does_not_raise_error_if_trying_to_connect_to_other_protected_environment_database_and_env_var_to_disable_check_is_set
    ClimateControl.modify DISABLE_DATABASE_ENVIRONMENT_CHECK: "1" do
      assert ActiveRecord::Base.protected_environments.include?("production")
      connect_to(:production)
      assert Foo.count
    end
  end

  private

  # Helper to establish new connection for each test
  def connect_to(env)
    ActiveRecord::Base.establish_connection YAML.safe_load(File.open(Rails.root.join("config/database.yml")).read)[env.to_s]
  end
end
