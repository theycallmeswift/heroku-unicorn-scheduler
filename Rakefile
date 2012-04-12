$LOAD_PATH.unshift File.dirname(__FILE__) unless $LOAD_PATH.include?(File.dirname(__FILE__))

require 'resque/tasks'
require 'resque_scheduler/tasks'

namespace :resque do
  task :setup do
    require 'resque'
    require 'resque_scheduler'
    require 'resque/scheduler'

    APP_ENV = ENV['APP_ENV'] ||= 'development'
    CONFIG = YAML.load(ERB.new(File.read('config/sendgrid.yml')).result)[APP_ENV]

    Resque.redis =    CONFIG['redis_uri']
    Resque.schedule = CONFIG['schedule']

    require 'scheduled_email'
  end
end
