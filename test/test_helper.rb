ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'
$redis = Redis.new
class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  Rails.application.config.active_job.queue_adapter = :test
end
