class LightStopwatch
  DEFAULT_TAG = 'Operation took:'
  @@ls_aggs = {}

  def self.agg_template
    {value: 0, count: 0}
  end

  def self.agg(key, &block)
    @@ls_aggs[key] ||= agg_template

    results = get_time(&block)

    @@ls_aggs[key][:count] += 1
    @@ls_aggs[key][:value] += results[:took]

    results[:retval]
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
      retval = yield
    stop = Time.now

    {took: (stop - start), retval: retval}
  end

  def self.measure(tag = DEFAULT_TAG, &block)
    results = get_time(&block)
    puts "#{tag} #{results[:took]}"

    results[:retval]
  end

  def self.reset
    @@ls_aggs = {}
  end
end

LS = LightStopwatch
