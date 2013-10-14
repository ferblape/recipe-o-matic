set :stage, :production
set :rbenv_ruby_version, 'ruby-2.0.0-p247'

server '198.211.121.11', user: 'ubuntu', roles: %w{web app db}, port: 2222, scm_user: 'ubuntu', use_sudo: false
