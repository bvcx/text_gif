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

helpers do
  def valid(text)
    !(text.nil? || text.empty?)
  end
end
