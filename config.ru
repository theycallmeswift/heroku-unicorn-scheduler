#!/usr/bin/env ruby
$LOAD_PATH.unshift File.dirname(__FILE__) unless $LOAD_PATH.include?(File.dirname(__FILE__))

require 'app'
require 'resque/server'

use Rack::ShowExceptions

$APP_ENV = ENV['APP_ENV'] ||= 'development'
$CONFIG = YAML.load(ERB.new(File.read('config/sendgrid.yml')).result)[$APP_ENV]

Resque.redis = $CONFIG['redis_uri']
run Rack::URLMap.new "/"       => SendGridDemo::App.new,
                     "/resque" => Resque::Server.new
