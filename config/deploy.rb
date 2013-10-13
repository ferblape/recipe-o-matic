set :application, "recipes"
set :repository,  "git@github.com:ferblape/recipe-o-matic.git"
set :deploy_via, :remote_cache
set :scm, :git
set :git_shallow_clone, 1
set :use_sudo, false
set :keep_releases, 5
set :deploy_to, "/var/www/#{fetch(:application)}"
set :deploy_type, :deploy

set :user, "ubuntu"
set :scm_user, "ubuntu"
set :use_sudo, false

after "deploy:updating" , "symlinks"

task :symlinks do
  on roles :app do |host|
    run <<-CMD
      ln -s #{shared_path}/cache #{release_path}/public/;
      ln -s #{shared_path}/uploads #{release_path}/public/;
      ln -s #{shared_path}/database.yml #{release_path}/config/;
    CMD
  end
end
