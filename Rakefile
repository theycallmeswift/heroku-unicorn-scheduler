$LOAD_PATH.unshift File.dirname(__FILE__) unless $LOAD_PATH.include?(File.dirname(__FILE__))
require 'resque/tasks'
require 'scheduled_email'

Resque.redis = ENV['REDIS_URI'] if ENV['REDIS_URI']