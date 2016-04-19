require 'helper'

class OmniAuth::Strategies::FidorTest < Minitest::Test
  def setup
    app = lambda { |_env| [404, {}, ['Awesome']] }
    @subject = OmniAuth::Strategies::Fidor.new(app)
    @sandbox = OmniAuth::Strategies::Fidor.new(app, '', '', false)
  end

  def teardown
    OmniAuth.config.test_mode = false
  end

  def test_options_has_correct_name
    assert_equal 'fidor', @subject.options.name
  end

  def test_options_does_not_set_provider_ignore_state
    refute @subject.options.provider_ignores_state
  end

  def test_client_options_has_correct_production_authorize_url
    assert_equal 'https://apm.fidor.de/oauth/authorize', @subject.client.authorize_url
  end

  def test_client_options_has_correct_staging_authorize_url
    assert_equal 'https://aps.fidor.de/oauth/authorize', @sandbox.client.authorize_url
  end

  def test_client_options_environment_variable_overrides_authorize_url
    around_env_url('FIDOR_OAUTH_URL', 'proto://another.url') do
      assert_equal 'proto://another.url/oauth/authorize', @sandbox.client.authorize_url
    end
  end

  def test_client_options_has_correct_production_site_url
    assert_equal 'https://api.fidor.de/', @subject.client.site
  end

  def test_client_options_has_correct_staging_site_url
    assert_equal 'https://aps.fidor.de/', @sandbox.client.site
  end

  def test_client_options_environment_variable_overrides_site_url
    around_env_url('FIDOR_API_URL', 'proto://another.url') do
      assert_equal 'proto://another.url/', @sandbox.client.site
    end
  end

  def test_client_options_has_correct_production_token_url
    assert_equal 'https://apm.fidor.de/oauth/token', @subject.client.token_url
  end

  def test_client_options_has_correct_staging_token_url
    assert_equal 'https://aps.fidor.de/oauth/token', @sandbox.client.token_url
  end

  def test_client_options_environment_variable_overrides_token_url
    around_env_url('FIDOR_OAUTH_URL', 'proto://another.url') do
      assert_equal 'proto://another.url/oauth/token', @sandbox.client.token_url
    end
  end

  private

  def around_env_url(env_key, url, &block)
    ENV[env_key] = url
    yield block.call
    ENV[env_key] = nil
  end
end
