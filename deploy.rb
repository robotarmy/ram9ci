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

role :app, "#{application}.robotarmymade.com"

before "deploy:symlink","deploy:#{application}_bootstrap"
after "deploy:symlink","deploy:#{application}_symlink"


 namespace :deploy do
  %w(start stop restart).each do |action|   
     desc "unicorn:#{action}"    
     task action.to_sym do  
        find_and_execute_task("unicorn:#{action}")  
     end  
   end 

   task "#{application}_bootstrap".to_sym do
     run <<-CMD
      mkdir -p #{shared_path}/system
      mkdir -p #{shared_path}/pids
     CMD
   end
   task "#{application}_symlink".to_sym do
     run <<-CMD
     CMD
   end

 end

 namespace :unicorn do
   task :restart, :roles => :app do
     run "kill -USR2 `cat #{deploy_to}/shared/pids/unicorn.pid`"  
   end
   task :start, :roles => :app do
     run "cd #{deploy_to}/current && bundle exec unicorn -c #{deploy_to}/current/config/unicorn.rb -E production -D config.ru"  
   end
   task :stop, :roles => :app do
     run "kill -QUIT `cat #{deploy_to}/shared/pids/unicorn.pid`"  
   end
 end

 #http://595959.javaeye.com/blog/713912
 namespace :log do  
   desc "Tail the Rails log..."  
   task :tail, :roles => :app do  
     run "tail -f #{deploy_to}/current/log/production.log" do |channel, stream, data|  
       puts  # for an extra line break before the host name  
       puts "#{channel[:server]} -> #{data}"   
       break if stream == :err      
     end  
   end  
 end  
