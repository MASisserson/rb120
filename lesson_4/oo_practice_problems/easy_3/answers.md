# Answers for Practice Problems: Easy 3

1. Cases:
  1. `"Hello"` outputted
  2. `undefined method error` Exception raised
  3. `ArgumentError` Exception raised
  4. `"Goodbye"` outputted
  5. `undefined method error` Exception raised

2. We could create a `self.hi` class method.

3. `ranky = AngryCat.new(10, 'ranky')` and `tony = AngryCat.new(1, 'Tony')`

4. 
```ruby
attr_reader :type

def to_s
  "I'm a #{self.type} cat"
end
```

5. `#manufacturer` can only be called on a Class, not an instance of that class. `#model` can
  only be called on an instance of a class, not the class.

6. We could have written `@age`.

7. Both the `:@brightness` and `:@color` instance variablesand their getter and setter methods.
  Importantly, `return` on `line 10` in unecessary. Ruby automatically returns the result of the
  last line of any menthod.
