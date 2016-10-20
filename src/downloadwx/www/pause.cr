get "/pause/:id" do |env|
  env.response.content_type = "application/json"
  id = env.params.url["id"].to_i
  begin
    D.pause(id)
    D[id].to_h
  rescue e
    env.response.status_code = 500
    {"message" => e.message}
  end
end
