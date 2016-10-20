require "uri"
require "tempfile"

class Download
  getter url : URI
  getter chan : Channel(String)
  getter state : Bool
  getter file : Tempfile

  @spawn : Fiber?

  def initialize(@url)
    @chan = Channel(String).new
    @state = false
    @spawn = nil
    @file = Tempfile.new(File.basename(@url.path || "foo"))
  end

  def initialize(url : String)
    @url = URI.parse url
    @chan = Channel(String).new
    @state = false
    @file = Tempfile.new(File.basename(@url.path || "foo"))
  end

  def path
    @file.path
  end

  def start
    if @state == false
      @spawn = spawn do
        # start download in a spawn
        http = spawn { `wget #{@url.to_s} -O #{file.as(Tempfile).path}` }
        # wait for an order
        case @chan.receive
        when "abort"
          http.resume rescue nil
          http = nil
        when "pause"
          #pause
        else
          raise "Unknown message"
        end
      end
    end
    self
  end

  def pause
    return self if @state == false
    @chan.send "pause"
    self
  end

  def abort
    return self if @state == false
    @chan.send "abort"
    self
  end
end
