require_relative 'bingauto'
require 'sinatra'

get '/' do
  @options = body_parser(send_request(params[:query]))
  erb :main
end
