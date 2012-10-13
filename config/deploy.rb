require "bundler/capistrano"

set :application, "application"
set :repository,  "git@github.com:railsrumble/r12-team-459.git"
set :scm, :git

server 'rtfm.r12.railsrumble.com', :app, :web, :db, primary: true
after "deploy:restart", "deploy:cleanup"

set :deploy_to,   "/root/#{application}/"
set :deploy_via,  :remote_cache
set :rails_env,   "production"

set :use_sudo, true
set :user,     "root"

namespace :deploy do
  task :start do
    run "cd #{deploy_to}/current && bundle exec unicorn -c #{deploy_to}/current/config/unicorn.rb -E #{rails_env} -D"
  end

  task :stop do
    run "if [ -e #{deploy_to}/shared/pids/unicorn.pid ]; then kill -QUIT `cat #{deploy_to}/shared/pids/unicorn.pid`; fi;"
  end

  task :restart do
    stop
    start
  end
end

load 'deploy/assets'
