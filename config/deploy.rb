require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'

set :domain, 'blato01'
set :deploy_to, '/var/www/recetas.blat.es'
set :repository, 'git@github.com:ferblape/recipe-o-matic.git'
set :branch, 'master'

set :shared_dirs, fetch(:shared_dirs, []).push('log', 'public/uploads', 'public/cache')
set :shared_files, fetch(:shared_files, []).push('config/database.yml')

set :user, 'ubuntu'
set :port, '22'
set :forward_agent, true

task :remote_environment do
  invoke :'rbenv:load'
end

task :setup do
  command %[mkdir -p "#{fetch(:deploy_to)}/shared/log"]
  command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/log"]

  command %[mkdir -p "#{fetch(:deploy_to)}/shared/config"]
  command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/config"]

  command %[touch "#{fetch(:deploy_to)}/shared/config/database.yml"]
  command  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]
end

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    on :launch do
      command "mkdir -p #{fetch(:deploy_to)}/#{fetch(:current_path)}/tmp/"
      command "touch #{fetch(:deploy_to)}/#{fetch(:current_path)}/tmp/restart.txt"
    end
  end
end
