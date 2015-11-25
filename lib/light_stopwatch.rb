module LightStopwatch
  def get_time(&block)
    LightStopwatch.get_time(&block)
  end

  def measure(&block)
    LightStopwatch.measure(&block)
  end

  def self.get_time(&block)
    start = Time.now
      yield
    stop = Time.now

    stop - start
  end

  def self.measure(&block)
    puts "Operation took: #{get_time(&block)}"
  end
end

LS = LightStopwatch
