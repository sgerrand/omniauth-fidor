require "codeclimate-test-reporter"
CodeClimate::TestReporter.start if ENV['CODECLIMATE_REPO_TOKEN']
require 'omniauth-fidor'

require 'minitest/autorun'
require 'minitest/pride'
