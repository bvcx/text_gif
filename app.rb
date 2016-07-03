require 'sinatra'
require 'net/http'
require 'json'

get '/' do
  @search_text = valid_search(params['s'])
  @phone_number = valid_phone(params['p'])
  erb :index
end

post '/' do
  @search_text = valid_search(params['s'])
  @phone_number = valid_phone(params['p'])
  erb :index
end

helpers do
  def valid_search(search)
    return nil if search.nil?
    return nil if search.empty?
    return search
  end

  def valid_phone(phone)
    return nil if phone.nil?
    phone.gsub!(/[^1-9]/, "")
    return "+1" + phone if phone.length == 10
    return "+" + phone if phone.length == 11 && phone.start_with?(1)
    return nil
  end

  def img(link)
    "<img src=#{link} />" unless link.nil?
  end

  def call_giphy(search_text)
    search_text = CGI::escape(search_text)
    url = "http://api.giphy.com/v1/gifs/search?q=#{search_text}&api_key=dc6zaTOxFJmzC&limit=1"
    response = Net::HTTP.get_response(URI.parse(url))
    buffer = response.body
    result = JSON.parse(buffer)
    result
  end

  def handle_response(response)
    return nil if response['data'].empty?
    @full_gif = response['data'][0]['images']['original']['url']
    @small_gif = response['data'][0]['images']['fixed_width']['url']
  end
end
