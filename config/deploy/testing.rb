#############################################################
#	Application
#############################################################

set :application, "nameofapp"
set :deploy_to, "/var/rails/#{application}"

#############################################################
#	Settings
#############################################################
default_run_options[:pty] = true
set :use_sudo, true
set :port, 2303

#############################################################
#	Servers
#############################################################

set :user, "user"
set :domain, "ip_to_domain"
set :runner, "user"
server domain, :app, :web
role :db, domain, :primary => true


#############################################################
#	Git
#############################################################

set :repository,  "git@github.com:"
set :scm, "git"
ssh_options[:forward_agent] = true
set :branch, "master"


#############################################################
#	Passenger
#############################################################

namespace :deploy do
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
 
desc "copies database yml and images symlink"
task :after_update_code, :roles=> :app do
  run "cp #{release_path}/config/production.database.yml #{release_path}/config/database.yml"
  run "ln -nfs /var/rails/#{application}/shared/frags #{release_path}/public/"
end
