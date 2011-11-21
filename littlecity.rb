require 'sinatra'

get "/" do
  erb :home
end

get '/form' do
  erb :form
end

post "/form" do
  num_eggs = params[:eggs].to_i
  cost = 5 # per dozen
  "Eggs: #{num_eggs} dozen at $#{cost}/dozen = $#{cost * num_eggs}"
end
