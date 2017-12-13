require 'sinatra'
require 'net/http'
require 'json'
require_relative './lib/messenger'
require_relative './helpers'

get '/' do
  @search_text = valid_search(params['s'])
  @phone_number = valid_phone(params['p'])
  if @search_text
    @results = call_giphy(@search_text)
    unless @phone_number.nil? || @results.empty?
      @gif_sent = send_gif(small_gif, @phone_number)
    end
  end
  erb :index
end
