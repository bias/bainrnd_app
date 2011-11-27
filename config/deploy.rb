##
##  Bundler
##
require 'bundler/capistrano'

##
## App/server config
##
set :application, "bainrnd_app"
set :user, "trevor"

set :use_sudo, false
ssh_options[:forward_agent] = true
#default_run_options[:pty] = true

set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache

##
## GIT 
##
set :scm, :git
set :gituser, "bias"
set :repository,  "git@github.com:#{gituser}/#{application}.git"
set :branch, "master"

## 
##  RVM
## 
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) 
require "rvm/capistrano"                  
set :rvmruby, "ruby-1.9.2-head"
set :rvm_ruby_string, "#{rvmruby}@#{application}"

##
##  Unicorn
##
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"
set :unicorn_socket, "#{current_path}/tmp/socket/unicorn.pid"

##
##  Cap Deploy Config
##
server "bainrnd.com", :app, :web, :db, :primary => true
set :rails_env, :production

##
##  Cap Deploy Custom  
##
namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{try_sudo} unicorn -c #{unicorn_config} -E #{rails_env} -D"
  end
  task :start_dev, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{try_sudo} unicorn -c #{unicorn_config} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill `cat #{unicorn_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
  task :schema_load, :roles => :app do
    run "cd #{current_path}; rake db:schema:load"
  end
  task :populate, :roles => :app do
    run "cd #{current_path}; rake db:populate"
  end
end

after 'deploy:setup' do 
  run "cd #{current_path}/.. && mkdir -p shared/socket"
end

after 'deploy:update' do 
  run "cd #{current_path}/.. && ln -s $PWD/shared/socket current/tmp/socket"
end
