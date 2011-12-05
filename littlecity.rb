require 'sinatra'
require 'data_mapper'

# need install dm-sqlite-adapter
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/littlecity.db")

class Item
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  property :quantity, Float
  property :units, String
  property :price, Float
end

# automatically create the post table
Item.auto_migrate! unless Item.storage_exists?
DataMapper.finalize

get "/" do
  erb :home
end

get "/form" do
  erb :form
end

post "/form" do
  @number_of_eggs = params[:eggs].to_i
  @eggs_price = 5 # per dozen
  @eggs_cost = @eggs_price * @number_of_eggs
    
  @number_of_peas = params[:peas].to_i
  @peas_price = 6 # per pound
  @peas_cost = @peas_price * @number_of_peas
  
  erb :calculation
end

get "/list" do
  @items = Item.all
  erb :list
end

get "/add" do
  @items = Item.all
  erb :add
end

post "/add" do
  Item.create(:name => params["name"], 
              :units => params["units"], 
              :quantity => 0, 
              :price => params["price"].to_f)
  redirect "/list"
end

get "/remove" do
  erb :remove
end

post "/remove" do
  item = Item.get(params["id"].to_i)
  item.destroy
  redirect "/list"
end