require 'sinatra'

get '/:name' do
  "Hi #{params[:name]}"
end

get '/profile' do # こちらには処理が到達しない
  'profile'
end