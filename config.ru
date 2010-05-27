require 'appengine-rack'
AppEngine::Rack.configure_app(
    :application => 'sinatra-example',
    :version => 1
    )
require 'guestbook'
run Sinatra::Application
