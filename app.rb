require 'sinatra'
set :bind, '0.0.0.0'

require './chart.rb'

get '/' do
  redirect 'https://github.com/defragworks/DelphiPentagonChart'
end

get '/chart' do
  chart = Chart.new(params)

  content_type 'image/png'
  chart.image
end