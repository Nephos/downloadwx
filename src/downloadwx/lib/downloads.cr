class Downloads; end

require "./download"

class Downloads
  getter downloads : Array(Download)

  def initialize
    @downloads = Array(Download).new
  end

  def add(d : Download)
    return nil if @downloads.includes? d
    @downloads << d
    d
  end

  def add(url : String)
    d = Download.new(url)
    @downloads << d
    d
  end

  {% for op in ["start", "pause", "abort"] %}
    def start(i : Int32)
      @downloads[i].{{op.id}}
    end
  {% end %}

    def remove(d : Int32)
      @downloads[i].remove
      @download.remove i
    end
end
