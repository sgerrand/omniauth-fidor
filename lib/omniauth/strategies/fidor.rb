require 'omniauth-oauth2'
require 'omniauth/fidor/config'

module OmniAuth
  module Strategies
    class Fidor < OmniAuth::Strategies::OAuth2
      option :authorize_options, [:authorization_code]

      option :client_options, {
        :authorize_url => OmniAuth::Fidor::Config.authorize_url,
        :site => OmniAuth::Fidor::Config.site,
        :token_url => OmniAuth::Fidor::Config.token_url,
      }

      option :scope, ['user']

      def request_phase
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

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('users/current').parsed
      end

      def email
        raw_info['email']
      end
    end
  end
end
