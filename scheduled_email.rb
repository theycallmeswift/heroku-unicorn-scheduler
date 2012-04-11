require 'resque'

module SendGridDemo
  module ScheduledEmail
    @queue = :mailer

    def self.perform(params)
      sleep 1
      puts "Processed a job!"
    end
  end
end
