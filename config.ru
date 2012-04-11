#!/usr/bin/env ruby
$LOAD_PATH.unshift File.dirname(__FILE__) unless $LOAD_PATH.include?(File.dirname(__FILE__))

require 'app'
require 'resque/server'

use Rack::ShowExceptions

Resque.redis = ENV['REDIS_URI'] if ENV['REDIS_URI']

run Rack::URLMap.new "/"       => SendGridDemo::App.new,
                     "/resque" => Resque::Server.new
