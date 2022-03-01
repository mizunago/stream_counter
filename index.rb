#!/home/ubuntu/.rbenv/versions/2.7.5/bin/ruby

APP_HOME = __dir__
load "#{APP_HOME}/app.rb"
NGINX = true
set :run, false

Rack::Handler::CGI.run Sinatra::Application
