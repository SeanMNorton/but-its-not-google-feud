def get_info  ## for command line program only
  puts "What are you searching?"
  request = gets.chomp
  body_parser(send_request(request))
end

def get_random_query
  File.readlines('./queries_list.txt').sample
end

def send_request(request_string)
  uri = URI('https://api.cognitive.microsoft.com/bing/v5.0/suggestions/')
  uri.query = URI.encode_www_form({
      'q' => request_string # Request parameters
  })

  request = Net::HTTP::Get.new(uri.request_uri)
  request['Ocp-Apim-Subscription-Key'] = ENV['KEY1'] # Request headers
  response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      return http.request(request)
  end
end

def body_parser(response)
  suggestions = []
  JSON.parse(response.body)["suggestionGroups"][0]['searchSuggestions'].each do |item|
    # enable for command line program
    # puts "#{item['displayText']}"
    suggestions << item['displayText']
  end
  suggestions
end

# enable to make command line program work
# get_info
