PROJECT_BASE_PATH = "/root/application"
ENV['RAILS_ENV'] = 'production'
worker_processes(4)
user('root','root')
timeout 40
listen "#{PROJECT_BASE_PATH}/shared/sockets/unicorn.sock"
working_directory "#{PROJECT_BASE_PATH}/current"
pid "#{PROJECT_BASE_PATH}/shared/pids/unicorn.pid"
stderr_path "#{PROJECT_BASE_PATH}/shared/log/unicorn.stderr.log"
stdout_path "#{PROJECT_BASE_PATH}/shared/log/unicorn.stdout.log"

preload_app true

GC.respond_to?(:copy_on_write_friendly=) and
GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

