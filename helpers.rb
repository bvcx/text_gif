#TODO: pull helpers out into another file / investigate other architectural options
#c.f. blog.sourcing.io/structuring-sinatra
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
    result = JSON.parse(buffer)
    result
  end

  #TODO: possibly incorporate this into call_giphy?
  def handle_response(response)
    return nil if response['data'].empty?
    @full_gif = response['data'][0]['images']['original']['url']
    @small_gif = response['data'][0]['images']['fixed_width']['url']
  end

  def send_gif(image_url, phone_number)
    Messenger.send_url(image_url, phone_number)
  end
end