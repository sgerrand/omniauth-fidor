require 'helper'

class OmniAuth::Fidor::ConfigTest < Minitest::Test
  def test_that_it_has_a_authorize_url
    refute_nil ::OmniAuth::Fidor::Config.authorize_url
  end

  def test_default_value_for_authorize_url
    assert_equal 'https://apm.fidor.de/oauth/authorize',
      ::OmniAuth::Fidor::Config.authorize_url
  end

  def test_override_value_for_authorize_url
    around_env_url('FIDOR_OAUTH_URL', 'https://another.url') do
      assert_equal 'https://another.url/oauth/authorize',
        ::OmniAuth::Fidor::Config.authorize_url
    end
  end

  def test_that_it_has_a_site
    refute_nil ::OmniAuth::Fidor::Config.site
  end

  def test_default_value_for_site
    assert_equal 'https://api.fidor.de/',
      ::OmniAuth::Fidor::Config.site
  end

  def test_override_value_for_site
    around_env_url('FIDOR_API_URL', 'https://another.url') do
      assert_equal 'https://another.url/',
        ::OmniAuth::Fidor::Config.site
    end
  end

  def test_that_it_has_a_token_url
    refute_nil ::OmniAuth::Fidor::Config.token_url
  end

  def test_default_value_for_token_url
    assert_equal 'https://apm.fidor.de/oauth/token',
      ::OmniAuth::Fidor::Config.token_url
  end

  def test_override_value_for_token_url
    around_env_url('FIDOR_OAUTH_URL', 'https://another.url') do
      assert_equal 'https://another.url/oauth/token',
        ::OmniAuth::Fidor::Config.token_url
    end
  end

  private

  def around_env_url(env_key, url, &block)
    ENV[env_key] = url
    yield block.call
    ENV[env_key] = nil
  end
end
