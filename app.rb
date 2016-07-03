require 'sinatra'

get '/' do
  @search_text = params['s']
  @phone_number = params['p']
  erb :index
end

post '/' do
  @search_text = params['s']
  @phone_number = params['p']
  erb :index
end
