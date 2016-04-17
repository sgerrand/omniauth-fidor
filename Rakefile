require 'echoe'

Echoe.new('omniauth-fidor') do |gem|
  gem.author        = 'Sasha Gerrand'
  gem.email         = 'rubygems-omniauth-fidor@sgerrand.com'
  gem.summary       = %q{OmniAuth strategy for the Fidor Banking API.}
  gem.description   = %q{An OmniAuth OAuth2 based strategy for the Fidor Banking API.}
  gem.url           = 'https://github.com/sgerrand/omniauth-fidor'
  gem.licenses      = 'MIT'
  gem.ruby_version  = '>= 2.0'
  gem.development_dependencies  = ['bundler ~>1.11', 'codeclimate-test-reporter', 'rake ~>10.0', 'minitest ~>5.0']
  # Nothing lower than omniauth-oauth2 1.1.1
  # http://www.rubysec.com/advisories/CVE-2012-6134/
  gem.runtime_dependencies      = ['omniauth ~>1.0', 'omniauth-oauth2 ~>1.3.1']
end
