module LightStopwatch
  DEFAULT_TAG = 'Operation took:'

  def get_time(&block)
    LightStopwatch.get_time(&block)
  end

  def measure(tag = DEFAULT_TAG, &block)
    LightStopwatch.measure(tag, &block)
  end

  def self.get_time(&block)
    start = Time.now
      yield
    stop = Time.now

    stop - start
  end

  def self.measure(tag = DEFAULT_TAG, &block)
    puts "#{tag} #{get_time(&block)}"
  end
end

LS = LightStopwatch
