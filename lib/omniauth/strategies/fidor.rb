require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Fidor < OmniAuth::Strategies::OAuth2
      FIDOR_API_HEADERS = {
        :headers => {
          'Accept' => 'application/vnd.fidor.de; version=1,text/json',
          'Content-Type' => 'application/json',
        },
      }.freeze
      FIDOR_API_URL = 'https://api.fidor.de'
      FIDOR_SANDBOX_URL = 'https://aps.fidor.de'
      FIDOR_OAUTH_URL = 'https://apm.fidor.de'

      args [:client_id, :client_secret, :production?]

      option :production?, true
      option :token_params, {
        grant_type: 'authorization_code',
      }

      uid { raw_info['id'].to_s }

      info do
        {
          'created_at' => raw_info['created_at'],
          'email' => raw_info['email'],
          'last_sign_in_at' => raw_info['last_sign_in_at'],
          'updated_at' => raw_info['updated_at'],
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def build_access_token
        verifier = request.params["code"]
        client.auth_code.get_token(verifier, {:client_id => client.id, :redirect_uri => callback_url}.merge(token_params.to_hash(:symbolize_keys => true)))
      end

      def client
        options.client_options.authorize_url = build_oauth_url('/oauth/authorize')
        options.client_options.site = build_api_url
        options.client_options.token_url = build_oauth_url('/oauth/token')

        super
      end

      def authorize_params
        super.tap do |params|
          %w[client_options scopes].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      def raw_info
        @raw_info ||= access_token.get('users/current', FIDOR_API_HEADERS).parsed
      end

      def email
        raw_info['email']
      end

      private

      def build_api_url
        if ENV['FIDOR_API_URL']
          ENV['FIDOR_API_URL']
        elsif options.production?
          FIDOR_API_URL
        else
          FIDOR_SANDBOX_URL
        end + '/'
      end

      def build_oauth_url(path)
        if ENV['FIDOR_OAUTH_URL']
          ENV['FIDOR_OAUTH_URL']
        elsif options.production?
          FIDOR_OAUTH_URL
        else
          FIDOR_SANDBOX_URL
        end + path
      end
    end
  end
end
