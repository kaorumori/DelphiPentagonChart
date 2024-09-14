require "sinatra"

require "./chart.rb"

get "/" do
  "DelphiPentagonChart"
end

get "/chart" do
  chart = Chart.new(params)

  content_type "image/png"
  chart.image
end
