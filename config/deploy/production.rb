set :stage, :production
set :branch, fetch(:branch, 'master')

set :port, "2222"

set :rbenv_ruby_version, 'ruby-2.0.0-p247'

role :app, "198.211.121.11"
role :web, "198.211.121.11"
role :db,  "198.211.121.11", primary: true
