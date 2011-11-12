require 'sinatra'

get "/" do
  "<html><body>
  <a href='/form'>View form</a>
  </body></html>"
end

get '/form' do
  "<html><body>
  <form method='post'>
  <input type='text' name='eggs'/>
  <input type='submit' value='Submit'/>
  </form>
  </body></html>"
end

post "/form" do
  "Eggs: #{params[:eggs]}"
end
