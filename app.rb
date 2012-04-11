require 'sinatra'
require 'resque'
require 'scheduled_email'

set :public_folder, File.dirname(__FILE__) + '/public'

module SendGridDemo
  class App < Sinatra::Application
    get '/' do
      send_file File.join(settings.public_folder, 'index.html')
    end

    post '/' do
      Resque.enqueue(ScheduledEmail, params)
      redirect "/"
    end
  end
end
