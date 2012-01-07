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

  belongs_to :category
end

class Category
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  
  has n, :items
end

# automatically create the post table
Item.auto_migrate! unless Item.storage_exists?
Category.auto_migrate! unless Category.storage_exists?
DataMapper.finalize

get "/" do
  erb :home
end

get "/form" do
  @items = Item.all
  erb :form
end

post "/form" do
  @ordered = []
  @total_price = 0
  params.each do |item_id,quantity_ordered|
    item = Item.get(item_id.to_i)
    paying = quantity_ordered.to_f * item.price
   item.update(:quantity => item.quantity - quantity_ordered.to_f)
    @ordered = @ordered + [{:name => item.name, 
                            :paying => paying, 
                            :price => item.price,
                            :units => item.units,
                            :quantity_ordered => quantity_ordered}] unless quantity_ordered.to_f == 0
    @total_price = @total_price + paying
  end
  
  erb :calculation
end

get "/list" do
  @items = Item.all
  erb :list
end

get "/add" do
  @items = Item.all
  @categories = Category.all
  erb :add
end

post "/add" do
  Item.create(:name => params["name"], 
              :units => params["units"], 
              :quantity => params["quantity"], 
              :price => params["price"].to_f,
              :category => Category.get(params["category"]))
              
  redirect "/list"
end
get "/edit" do
@item = Item.get(params["id"].to_i)
  erb :edit
end

post "/edit" do
  item = Item.get(params["id"].to_i)
  #item.update(params)
  item.update(:name => params["name"], 
              :units => params["units"], 
              :quantity => params["quantity"], 
              :price => params["price"].to_f,
              :category => Category.get(params["category"]))
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

get "/list_categories" do
  @categories = Category.all
  erb :list_categories
end

get "/add_category" do
  @categories = Category.all
  erb :add_category
end

post "/add_category" do
  Category.create(:name => params["name"])
              
  redirect "/list_categories"
end
get "/edit_category" do
@category = Category.get(params["id"].to_i)
  erb :edit_category
end

post "/edit_category" do
  category = Category.get(params["id"].to_i)
  category.update(:name => params["name"])
             
  redirect "/list_categories"
end

get "/remove_category" do
  erb :remove
end

post "/remove_category" do
  category = Category.get(params["id"].to_i)
  category.destroy
  redirect "/list_category"
end