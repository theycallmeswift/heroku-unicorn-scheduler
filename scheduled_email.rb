require 'erb'
require 'sendgrid_toolkit'
require 'yaml'

APP_ENV = ENV['APP_ENV'] ||= 'development'
CONFIG = YAML.load(ERB.new(File.read('config/sendgrid.yml')).result)[APP_ENV]

SendgridToolkit.api_user = CONFIG['username']
SendgridToolkit.api_key =  CONFIG['api_key']

module SendGridDemo
  module ScheduledEmail
    @queue = :demo_mailer
    @mailer = SendgridToolkit::Mail.new

    def self.perform(params)
      @mailer.send_mail :to => params['to'],
                        :from => CONFIG['from_address'],
                        :subject => params['subject'],
                        :html => params['body']
    end
  end
end
