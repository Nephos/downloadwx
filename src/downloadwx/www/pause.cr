get "/pause/:id" do |env|
  id = env.params.url["id"].to_i
  D.pause(id)
  D[id].to_h
end
