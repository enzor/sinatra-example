require 'sinatra'
require 'dm-core'

DataMapper.setup(:default, "appengine://auto")

class Shout
  include DataMapper::Resource
  
  property :id, Serial
  property :message, Text
end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

get '/' do
  @shouts = Shout.all
  erb :index
end

post '/' do
  shout = Shout.create(:message => params[:message])
  redirect '/'
end

__END__

@@ index
<html>
  <head>
    <title>Shoutout!</title>
  </head>
  <body style="font-family: sans-serif;">
    <h1>Shoutout!</h1>

    <form method=post>
      <textarea name="message" rows="3"></textarea>
      <input type=submit value=Shout>
    </form>

    <% @shouts.each do |shout| %>
    <p>Someone wrote, <q><%=h shout.message %></q></p>
    <% end %>

    <div style="position: absolute; bottom: 20px; right: 20px;">
    <img src="/images/appengine.gif"></div>
  </body>
</html>