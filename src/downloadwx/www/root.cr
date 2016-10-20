get "/" do
  D.downloads.map(&.url).map(&.to_s)
end
