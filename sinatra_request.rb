require 'sinatra'

get '/' do
  puts "params                  => #{params}"
  puts "params.class            => #{request.inspect}"
  puts "request                 => #{request.class.ancestors}"

  'request sample'
end