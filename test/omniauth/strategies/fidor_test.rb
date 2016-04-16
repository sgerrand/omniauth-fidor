require 'helper'

class OmniAuth::Strategies::FidorTest < Minitest::Test
  def setup
    app = lambda { |_env| [404, {}, ['Awesome']] }
    @subject = OmniAuth::Strategies::Fidor.new(app)
    OmniAuth.config.test_mode = true
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

  def test_client_options_has_correct_site
    assert_equal 'https://api.fidor.de/', @subject.options.client_options.site
  end

  def test_client_options_has_correct_authorize_url
    assert_equal 'https://apm.fidor.de/oauth/authorize', @subject.options.client_options.authorize_url
  end

  def test_client_options_has_correct_token_url
    assert_equal 'https://apm.fidor.de/oauth/token', @subject.options.client_options.token_url
  end
end
