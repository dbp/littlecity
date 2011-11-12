require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/littlecity.db")

class Item 
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  property :quantity, Float
  property :units, String
  property :price, Float
end

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
