require 'uri'
require 'net/http'
require 'json'

def get_info  ## for command line program only
  puts "What are you searching?"
  request = gets.chomp
  body_parser(request, send_request(request))
end

def get_random_query
  File.readlines('./queries_list.txt').sample
end

def send_request(request_string)
  request_string = request_string.split(" ").join("+") + " + " # doesn't appear to work
  uri = URI('https://api.cognitive.microsoft.com/bing/v5.0/suggestions/')
  uri.query = URI.encode_www_form({
      'q' => "#{request_string}" # Request parameters
  })

  request = Net::HTTP::Get.new(uri.request_uri)
  request['Ocp-Apim-Subscription-Key'] = ENV['KEY1'] # Request headers
  # request['WebSearchOptions'] = 'DisableQueryAlterations' # doesn't appear to work
  response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      return http.request(request)
  end
end

def body_parser(original_query, response)
  suggestions = []
  JSON.parse(response.body)["suggestionGroups"][0]['searchSuggestions'].each do |line|
    p line['displayText']
    line_text = line["displayText"].gsub('+', " ")
    # enable for command line program
    if line_text.match(/^#{original_query.chomp}\b.+/i)
      suggestions << line_text
    end
  end
  query = Query.create(statement: original_query, responses: suggestions)
  # query.repsonses = suggestions
end

# enable to make command line program work
# get_info
