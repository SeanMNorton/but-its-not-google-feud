require 'net/http'
require 'json'

def get_info
  puts "What are you searching?"
  request = gets.chomp
  body_parser(send_request(request))
end

def send_request(request_string)
  uri = URI('https://api.cognitive.microsoft.com/bing/v5.0/suggestions/')
  uri.query = URI.encode_www_form({
      # Request parameters
      'q' => request_string
  })

  request = Net::HTTP::Get.new(uri.request_uri)
  # Request headers
  request['Ocp-Apim-Subscription-Key'] = 'KEY GOES HERE' #REMOVE KEY WHEN COMMITING
  # Request body
  request.body = "{body}"

  response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      return http.request(request)
  end
end

def body_parser(response)
  num = 0
  JSON.parse(response.body)["suggestionGroups"][0]['searchSuggestions'].each do |item|
    puts "#{num+=1}) #{item['displayText']}"
  end
end


get_info
