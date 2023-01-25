# in a file called server.rb
require 'sinatra'

get '/api' do
  # this block defines the behavior of the API endpoint
  # you can use it to return data or perform some other action
  # in response to a request
  { message: 'Hello from the API!' }.to_json
end
