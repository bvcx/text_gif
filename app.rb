require 'sinatra'
require 'net/http'
require 'json'
require_relative './lib/messenger'
require_relative './helpers'

get '/' do
  @search_text = valid_search(params['s'])
  @phone_number = valid_phone(params['p'])
  erb :index
end
