# require_relative 'bingauto'
# require 'sinatra'
get '/' do
  if params[:query]
    @options = body_parser(send_request(params[:query]))
  end
  erb :main
end
