class Downloads; end

require "./download"

class Downloads
  getter downloads : Array(Download)

  def initialize
    @downloads = Array(Download).new
  end

  def [](idx : Int32)
    @downloads[idx]
  end

  def []?(idx : Int32)
    @downloads[idx] rescue nil
  end

  def add(d : Download)
    return nil if @downloads.includes? d
    @downloads << d
    d.id = @downloads.size - 1
    d
  end

  def add(url : String)
    d = Download.new(url)
    @downloads << d
    d.id = @downloads.size - 1
    d
  end

  def remove(d : Int32)
    @downloads[i].remove
    @downloads.remove i
  end

  {% for op in ["start", "pause", "abort", "resume"] %}
    def {{op.id}}(i : Int32)
      @downloads[i].{{op.id}}
    end
  {% end %}

end
