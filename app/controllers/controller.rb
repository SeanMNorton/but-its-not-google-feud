# require_relative 'bingauto'
# require 'sinatra'
get '/' do
  if session[:query]
    @options = body_parser(send_request(session[:query]))
    session.delete(:query)
  end
  erb :main
end

post '/' do
  session[:query] = params[:query] if params[:query]
  redirect back
end
