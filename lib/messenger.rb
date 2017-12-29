require 'yaml'
require 'twilio-ruby'

module Messenger

  #TODO: Consider setting up the client outside this method, so that it can be reused for subsequent calls.
  def self.send_url(image_url, phone_number)
    return false if environment_not_set_up
    client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    message_body = ""
    twilio_number = ENV['TWILIO_FROM_NUMBER']
    begin
      client.messages.create(
        from: twilio_number,
        to: phone_number,
        body: message_body,
        media_url: image_url
      )
      puts "sent gif #{image_url} to #{phone_number}"
      return true
    rescue Twilio::REST::RequestError => e
      puts e
      return false
    end
  end

  def self.environment_not_set_up
    ENV['TWILIO_ACCOUNT_SID'].nil? || ENV['TWILIO_AUTH_TOKEN'].nil? || ENV['TWILIO_FROM_NUMBER'].nil?
  end
end
