get "/pause/:id" do |env|
  env.response.content_type = "application/json"
  id = env.params.url["id"].to_i
  D.pause(id)
  D[id].to_h
end
