require "base64"
# require "./add/*"

get "/add/:base64" do |env|
  url = Base64.decode_string(env.params.url["base64"])
  d = D.add(url).start
  {
    "id" => d.id,
    "url" => d.path,
  }
end
