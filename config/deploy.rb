default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :application, "recipes"
set :repository,  "git@github.com:ferblape/recipe-o-matic.git"
set :scm, :git
set :branch, "master"
set :git_shallow_clone, 1
set :scm_user, "ubuntu"
set :use_sudo, false
set :keep_releases, 5
set :user, "ubuntu"
set :port, "2222"
set :deploy_to, "/var/www/#{application}"
set :host, "198.211.121.11" 
set :stage, "production"

role :app, host
role :web, host
role :db,  host, primary: true

after "deploy:finalize_update" , "symlinks"
after "deploy:restart", "deploy:cleanup"
after "deploy:update_code",     "bundle:install"
after "deploy:create_symlink",  "run_migrations"

desc "Restart Application"
deploy.task :restart, roles: [:app] do
  run "touch #{current_path}/tmp/restart.txt"
end

desc "Run migrations"
task :run_migrations, roles: [:app] do
  run <<-CMD
    cd #{release_path} &&
    #{rake} RAILS_ENV=#{stage} db:migrate --trace
  CMD
end

task :symlinks, roles: [:app] do
  run <<-CMD
    ln -s #{shared_path}/cache #{release_path}/public/;
    ln -s #{shared_path}/uploads #{release_path}/public/;
    ln -s #{shared_path}/database.yml #{release_path}/config/;
  CMD
end
