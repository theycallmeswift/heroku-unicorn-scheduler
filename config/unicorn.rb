worker_processes 3
preload_app true
timeout 30

@resque_pid = nil
@resque_sched_pid = nil

before_fork do |server, worker|
  @resque_pid ||= spawn("bundle exec rake resque:work QUEUES=*")
  @resque_sched_pid ||= spawn("bundle exec rake resque:scheduler")
end
