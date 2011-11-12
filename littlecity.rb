require 'sinatra'

get "/" do
  "<html><body>
  <a href='/form'>View form</a>
  </body></html>"
end

get '/form' do
  "<html><body>
  <form method='post'>
  Dozens of eggs: <input type='text' name='eggs'/>
  <input type='submit' value='Submit'/>
  </form>
  </body></html>"
end

post "/form" do
  num_eggs = params[:eggs].to_i
  cost = 5 # per dozen
  "Eggs: #{num_eggs} dozen at $#{cost}/dozen = $#{cost * num_eggs}"
end
