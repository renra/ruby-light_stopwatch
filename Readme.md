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
=> Operation took: 10
```

If you want to get only the time ...

```ruby
LS.get_time do
  # task you want profiled
end
=> 10
```

You can also include Stopwatch as a module

```ruby
class MyObject
  include LS

  def do_stuff
    measure do
      # do more stuff
    end
  end
end
```

##Customizing output

If you're not happy with the default `Operation took:` output or you want to separate multiple measurements you can customize like this:

```ruby
LS.measure('my_stuff:') do
  # task you want profiled
end
=> my_stuff: 10
```


**Enjoy**!
