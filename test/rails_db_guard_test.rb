require "test_helper"

class RailsDbGuardTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RailsDbGuard::VERSION
  end


  def test_it_does_not_raise_error_if_trying_to_connect_to_current_environment_database
    assert Foo.count
  end

  def test_it_raises_error_if_trying_to_connect_to_other_protected_environment_database
    assert ActiveRecord::Base.protected_environments.include?("production")
    assert_raises RailsDbGuard::Error do
      FooProduction.count
    end
  end

  def test_it_does_not_raise_error_if_trying_to_connect_to_other_environment_database_that_is_not_protected
    refute ActiveRecord::Base.protected_environments.include?("development")
    assert FooDevelopment.count
  end

  def test_it_does_not_raise_error_if_trying_to_connect_to_current_environment_if_it_is_protected
    assert ActiveRecord::Base.protected_environments.include?("production")
    Rails.stub("env", "production") do
      assert Foo.count
    end
  end
end
