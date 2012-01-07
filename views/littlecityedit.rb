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
              :price => params["price"].to_f)
  redirect "/list"
end