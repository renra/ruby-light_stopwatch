# Light Stopwatch

This is a more lightweight alternative to ruby-prof that handles only time measurements.

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

```
class MyObject
  include LS

  def do_stuff
    measure do
      # do more stuff
    end
  end
end
```

**Enjoy**!
