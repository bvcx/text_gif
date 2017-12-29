require 'sinatra'
require 'net/http'
require 'json'
require_relative './lib/messenger'

get '/' do
  search_text = valid_search(params['s'])
  phone_number = valid_phone(params['p'])
  if search_text.nil?
    @message = "Please enter valid search text."
  else # search text is valid
    @results = call_giphy(search_text)
    if @results.empty?
      @message = "No results for search text #{search_text}."
    else # results non-empty
      if phone_number.nil?
        @message = "Enter a valid phone number to send a gif as a text message."
      else # phone number is valid
        if send_gif(small_gif, phone_number)
          @message = "Sent gif related to search text \"#{search_text}\" to phone number \"#{phone_number}\"."
        else # send_gif failed; probably environment variables weren't initialized
          #TODO: Consider not allowing phone numbers to be input if environment variables weren't initialized.
          # This could distinguish giphy errors from env errors.
          @message = "Something went wrong. Try another search, or phone number?"
        end
      end
    end
  end

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
    phone.gsub!(/[^0-9]/, "")
    return "+1" + phone if phone.length == 10
    return "+" + phone if phone.length == 11 && phone.start_with?("1")
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
    JSON.parse(buffer)['data']
  end

  def full_gif
    @results[0]['images']['original']['url']
  end

  def small_gif
    @results[0]['images']['fixed_width']['url']
  end

  def send_gif(image_url, phone_number)
    Messenger.send_url(image_url, phone_number)
  end
end
