set :application, 'recipes'
set :repo_url, 'git@github.com:ferblape/recipe-o-matic.git'
set :branch, 'master'
set :deploy_via, :remote_cache
set :scm, :git
set :git_shallow_clone, 1
set :keep_releases, 5
set :deploy_to, "/var/www/#{fetch(:application)}"
set :deploy_type, :deploy

after 'deploy:updating', 'symlinks'

task :symlinks do
  on roles :app do
    execute "ln -s #{shared_path}/cache #{release_path}/public/;"
    execute "ln -s #{shared_path}/uploads #{release_path}/public/;"
    execute "ln -s #{shared_path}/database.yml #{release_path}/config/;"
  end
end
