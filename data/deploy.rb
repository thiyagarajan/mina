require 'van_helsing/bundler'
require 'van_helsing/rails'
require 'van_helsing/git'

# Basic settings:
# host       - The hostname to SSH to
# deploy_to  - Path to deploy into
# repository - Git repo to clone from (needed by van_helsing/git)
# user       - Username in the  server to SSH to (optional)

set :host, 'foobar.com'
set :deploy_to, '/var/www/foobar.com'
set :repository, 'git://...'
# set :user, 'foobar.com'

task :deploy do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:checkout'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :restart do
      queue 'touch tmp/restart.txt'
    end
  end
end
