set :rvm_type, :system
set :rvm_ruby_string, 'ruby-1.9.2' 
set :application, "ram9ci"
set :user , application
set :use_sudo, false
set :deploy_to, "/home/#{application}/deploy/"
set :repository,  "git://github.com/robotarmy/#{application}.git"
set :scm, :git
set :branch, 'master'

#set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true

role :app, "robotarmymade.com"
role :db, "robotarmymade.com"
#role :app, "#{application}.robotarmymade.com"

before "deploy:cold","deploy:#{application}_bootstrap"
after "deploy:symlink","deploy:#{application}_symlink"

 namespace :deploy do
   task "#{application}_bootstrap".to_sym do
     run "mkdir -p #{shared_path}/system"
     run "mkdir -p #{shared_path}/pids"
   end
   task "#{application}_symlink".to_sym do
   end
 end
