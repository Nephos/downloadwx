get "/resume/:id" do |env|
  id = env.params.url["id"].to_i
  D.resume env.params.url["id"].to_i
  D[id].to_h
end
