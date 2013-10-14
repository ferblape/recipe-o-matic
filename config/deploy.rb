require "capistrano-rbenv"
set :rbenv_ruby_version, "2.0.0-p247"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :application, 'recipes'
set :repository, 'git@github.com:ferblape/recipe-o-matic.git'

set :branch, "master"
set :scm, :git
set :git_shallow_clone, 1
set :scm_user, "ubuntu"
set :use_sudo, false
set :keep_releases, 5
set :user, "ubuntu"
set :port, "2222"
set :deploy_to, "/var/www/#{application}"
set :appserver, "198.211.121.11"
set :rake, "/usr/bin/env rake"
set :asset_env, ""

role :app, appserver
role :web, appserver
role :db,  appserver, primary: true
set :rails_env, "production"

after  "deploy:finalize_update", "symlinks"
after  "deploy:finalize_update", "bundle:install"
after  "deploy:create_symlink",  "run_migrations"
after  "deploy",                 "deploy:cleanup"

desc "Restart Application"
deploy.task :restart, roles: [:app] do
  run "touch #{current_path}/tmp/restart.txt"
end

desc "Run migrations"
task :run_migrations, roles: [:app] do
  run <<-CMD
    cd #{current_path} &&
    #{rake} RAILS_ENV=#{rails_env} db:migrate --trace
  CMD
end

task :symlinks, roles: [:app] do
  run <<-CMD
    ln -s #{shared_path}/cache #{release_path}/public/;
    ln -s #{shared_path}/uploads #{release_path}/public/;
    cp #{shared_path}/database.yml #{release_path}/config/;
  CMD
end

namespace :bundle do
  task :install, roles: [:app] do
    run "cd #{release_path} && /usr/bin/env bundle --gemfile #{release_path}/Gemfile --path #{shared_path}/bundle --deployment --quiet --binstubs #{shared_path}/bin --without development test"
  end
end
