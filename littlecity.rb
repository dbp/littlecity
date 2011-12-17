require 'sinatra'
require 'data_mapper'

# need install dm-sqlite-adapter
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/littlecity.db")

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
  @items = Item.all
  erb :form
end

post "/form" do
  
  # this is where we were working... - daniel @ Dec 10, 2011
  @items = Item.all  
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
              :quantity => params["quantity"], 
              :price => params["price"].to_f)
              
  redirect "/list"
end
get "/edit" do
@item = Item.get(params["id"].to_i)
  erb :edit
end

post "/edit" do
  item = Item.get(params["id"].to_i)
  
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

