require 'yaml'
require 'twilio-ruby'

module Messenger
  def self.send_url(image_url, phone_number)
    return if environment_not_set_up
    client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    message_body = ""
    twilio_number = ENV['TWILIO_FROM_NUMBER']
    message = client.messages.create(
      from: twilio_number,
      to: phone_number,
      body: message_body,
      media_url: image_url
    )
    puts "sent gif #{image_url} to #{phone_number}"
  end

  def self.environment_not_set_up
    ENV['TWILIO_ACCOUNT_SID'].nil? || ENV['TWILIO_AUTH_TOKEN'].nil? || ENV['TWILIO_FROM_NUMBER'].nil?
  end
end
