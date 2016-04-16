require 'uri'

module OmniAuth
  module Fidor
    class Config
      class << self
        def authorize_url
          oauth_url + '/oauth/authorize'
        end

        def site
          api_url + '/'
        end

        def token_url
          oauth_url + '/oauth/token'
        end

        private

        def api_url
          ENV['FIDOR_API_URL'] || 'https://api.fidor.de'
        end

        def oauth_url
          ENV['FIDOR_OAUTH_URL'] || 'https://apm.fidor.de'
        end
      end
    end
  end
end
