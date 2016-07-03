require 'sinatra'
require 'net/http'
require 'json'

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

  def img(link)
    "<img src=#{link} />"
  end

  def call_giphy(search_text)
    search_text = CGI::escape(search_text)
    url = "http://api.giphy.com/v1/gifs/search?q=#{search_text}&api_key=dc6zaTOxFJmzC&limit=1"
    puts url
    response = Net::HTTP.get_response(URI.parse(url))
    buffer = response.body
    result = JSON.parse(buffer)
    result['data'][0]['images']['fixed_width']['url']
  end
end
