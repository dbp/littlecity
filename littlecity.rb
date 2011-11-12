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
  number_of_eggs = params[:eggs].to_i
  eggs_price = 5 # per dozen
  eggs_cost = eggs_price * number_of_eggs
  
  number_of_peas = params[:peas].to_i
  peas_price = 6 # per pound
  peas_cost = peas_price * number_of_peas
  
  "Eggs: #{number_of_eggs} dozen at $#{eggs_price}/dozen = $#{eggs_cost}<br>
   Peas: #{number_of_peas} pounds at $#{peas_price}/pound = $#{peas_cost}<br>
   Total: $#{eggs_cost + peas_cost}"
end
