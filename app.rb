require 'sinatra'
require 'resque'
require 'resque_scheduler'
require 'resque/scheduler'
require 'scheduled_email'

set :public_folder, File.dirname(__FILE__) + '/public'

module SendGridDemo
  class App < Sinatra::Application
    get '/' do
      send_file File.join(settings.public_folder, 'index.html')
    end

    post '/schedule' do
      content_type :json
      full_params = params.values.select { |value| !value.empty? }

      if full_params.length == params.keys.length
        time = (params['length'].to_i * params['unit'].to_i)
        Resque.enqueue_in(time, ScheduledEmail, params)
        puts "SENDING MESSAGE: #{params}"
        { :message => "Your email has been queued for delivery!" }.to_json
      else
        status 406
        { :message => "All fields are required to send your message" }.to_json
      end
    end
  end
end
