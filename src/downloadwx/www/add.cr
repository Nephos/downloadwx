require "base64"
# require "./add/*"

get "/add/:base64" do |env|
  url = Base64.decode_string(env.params.url["base64"])
  file = D.add(url).start.path
  puts "------------ #{file} ------------"
  file
end
