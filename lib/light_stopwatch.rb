class LightStopwatch
  DEFAULT_TAG = 'Operation took:'
  @@ls_aggs = {}

  def self.agg_template
    {value: 0, count: 0}
  end

  def self.agg(key, &block)
    @@ls_aggs[key] ||= agg_template

    @@ls_aggs[key][:count] += 1
    @@ls_aggs[key][:value] += get_time(&block)
  end

  def self.get_aggs
    @@ls_aggs
  end

  def self.get_agg(key)
    @@ls_aggs[key]
  end

  def self.get_agg_count(key)
    @@ls_aggs[key] && @@ls_aggs[key][:count]
  end

  def self.get_agg_value(key)
    @@ls_aggs[key] && @@ls_aggs[key][:value]
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

  def self.reset
    @@ls_aggs = {}
  end
end

LS = LightStopwatch
