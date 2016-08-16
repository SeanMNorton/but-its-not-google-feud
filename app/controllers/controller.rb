# require_relative 'bingauto'
# require 'sinatra'
get '/' do
  @query = Query.last
  erb :main
end

post '/' do
  @query = get_random_query
  @query = body_parser(@query, send_request(@query))
  redirect back
end
