# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

set :application, 'ci_cd'
set :user, 'ubuntu'
set :domain, '44.203.31.43'
set :repo_url, 'git@github.com:samirlama/ci-cd.git'
set :branch, :master
set :deploy_to, "/home/ubuntu/#{fetch(:application)}"
set :pty, true
set :linked_files, %w{config/database.yml config/application.yml config/master.key}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockests vendor/bundle public/system public/uploads}
set :keep_releases, 5
set :rbenv_ruby, '2.5.1'
set :ssh_options,     { forward_agent: true, user: 'ubuntu', keys: %w(~/.ssh/id_rsa.pub) }
set :rails_env, 'production'

set :default_env, {
PATH: '$HOME/.nvm/versions/node/v10.24.1/bin/:$PATH'
}

set :ssh_options, {
  forward_agent: true,
  auth_methods: ["publickey"],
  keys: [ENV['SSH_PRIVATE_KEY']]
}

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
desc "Create database.yml file"
namespace :deploy do
  task :create_database_yml do
    on roles(:app) do
      execute :mkdir, "-p", 'shared/config'
      within shared_path do
        execute :touch, 'config/database.yml'
        execute :touch, 'config/application.yml'
        # database_yml = <<~DATABASE_YML
        #    production:
        #       adapter: postgresql
        #       encoding: unicode
        #       pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
        #       database: my_database
        #       username: denji
        #       password: my_password
        #       host: localhost
        # DATABASE_YML
        #
        # execute :echo, "\"#{database_yml}\" > config/database.yml"
      end
    end
  end
end

# namespace :git do
#   task :clone do
#     on roles(:app) do
#       `git clone --mirror git@github.com:samirlama/ci-cd.git /home/ubuntu/ci_cd/repo`
#     end
#   end
# end

before 'deploy:check:linked_files', 'deploy:create_database_yml'