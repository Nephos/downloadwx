require "base64"
# require "./add/*"

private def add_url(url : String)
  d = D.add(url).start
  {
    "id" => d.id,
    "url" => d.path,
  }
end

get "/add/:base64" do |env|
  env.response.content_type = "application/json"
  url = Base64.decode_string(env.params.url["base64"])
  add_url(url)
end

post "/add" do |env|
  env.response.content_type = "application/json"
  url = env.params.body["url"]
  add_url(url)
end
