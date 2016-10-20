get "/resume/:id" do |env|
  env.response.content_type = "application/json"
  id = env.params.url["id"].to_i
  D.resume env.params.url["id"].to_i
  D[id].to_h
end
