worker_processes 2
preload_app true
timeout 30

@resque_pid = nil

before_fork do |server, worker|
  @resque_pid ||= spawn("bundle exec rake resque:work QUEUE=demo_mailer")
end
