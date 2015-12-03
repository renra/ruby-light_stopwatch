[![wercker status](https://app.wercker.com/status/676f639c9e4b29ec7b6cbcc15bb96cad/m "wercker status")](https://app.wercker.com/project/bykey/676f639c9e4b29ec7b6cbcc15bb96cad)

# Light Stopwatch

This is a more lightweight alternative to ruby-prof that handles only time measurements.

##Installation

```
gem install 'light_stopwatch'
```

##Usage

You can use the `LightStopwatch` module or `LS` as a shortcut

```ruby
LS.measure do
  # task you want profiled
end
Operation took: 10
=> 'whateber you returned'
```

If you want to get only the time ...

```ruby
LS.get_time do
  # task you want profiled
end
=> { :took => 10.00xx, retval => 'whatever you returned' }
```

##Customizing output

If you're not happy with the default `Operation took:` output or you want to separate multiple measurements you can customize like this:

```ruby
LS.measure('my_stuff:') do
  # task you want profiled
end
my_stuff: 10
=> 'whatever you returned'
```

##Aggregations

If you want to measure a total time spent in a codepath that is called multiple times you need an aggregation.

```ruby
100.times do
  LS.agg(:foo) do
    sleep(0.01)
  end
end

10.times do
  LS.agg(:bar) do
    sleep(1)
  end
end

LS.get_aggs
=> {:foo=>{:value=>1.16, :count=>100}, :bar=>{:value=>10.039352, :count=>10}}  # time measurements of sleep vary

LS.get_agg(:foo)
=> {:value=>1.16, :count=>100}

LS.get_agg(:bar)
=> {:value=>10.039352, :count=>10}

LS.get_agg_value(:bar)
=> 10.039352

LS.get_agg_count(:bar)
=> 10
```

`LS.agg` also returns whatever the inner block returns


**Enjoy**!
