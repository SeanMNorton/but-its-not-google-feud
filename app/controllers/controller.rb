# require_relative 'bingauto'
# require 'sinatra'
get '/' do
  @query = get_random_query
  @options = body_parser(@query, send_request(@query.statement))
  # @query.responses = @options
  if session[:query]
    session.delete(:query)
  end
  erb :main
end

post '/' do
  session[:query] = params[:query] if params[:query]
  redirect back
end
