require "uri"
require "tempfile"

class Download
  property id : Int32
  getter url : URI
  getter chan : Channel(String)
  getter state : String
  getter file : Tempfile

  @spawn : Fiber?
  @proc : Process?

  def initialize(@url)
    @id = -1
    @chan = Channel(String).new
    @state = false
    @spawn = "waiting"
    @file = Tempfile.new(File.basename(@url.path || "foo"))
    @proc = nil
  end

  def initialize(url : String)
    @id = -1
    @url = URI.parse url
    @chan = Channel(String).new
    @state = "waiting"
    @file = Tempfile.new(File.basename(@url.path || "foo"))
    @proc = nil
  end

  def to_h
    {"id" => id, "url" => url.to_s, "state" => state, "file" => file.path}
  end

  def path
    @file.path
  end

  def start
    return self if @state != "waiting"
    @state = "started"
    @spawn = spawn do
      _handle_download
    end
    self
  end

  def pause
    return self if @state != "started"
    @state = "paused"
    @chan.send "pause"
    self
  end

  def resume
    return self if @state != "paused"
    @state = "started"
    @chan.send "resume"
    self
  end

  def abort
    return self if @state == "waiting"
    @state = "waiting"
    @chan.send "abort"
    self
  end

  private def _handle_download
    spawn { @proc = _start_wget(@url, @file.path) }
    loop { _handle_orders }
  end

  # returns the pid to pause/resume
  private def _start_wget(url, path)
    Process.fork do |f|
      Process.exec("wget", [url.to_s, "-O", file.path])
    end
  end

  private def _handle_orders
    order = @chan.receive
    case order
    when "abort"
      @proc.as(Process).kill(Signal::TERM) if !@proc.nil?
    when "pause"
      @proc.as(Process).kill(Signal::STOP) if !@proc.nil?
    when "resume"
      @proc.as(Process).kill(Signal::CONT) if !@proc.nil?
    #resume
    else
      raise "Unknown message"
    end
  end
end
