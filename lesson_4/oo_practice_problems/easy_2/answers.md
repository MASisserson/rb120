## Answers for Practice Problems: Easy 2

1. Nothing will be output to the console. `line 12` will return `"You will "` followed by
  one of three possible choices seen on `line 7`. The choice will be made randomly.

2. `"You will "` followed by one of the choices present in the array on `line 13` will be
  returned. The `choices` instance method on `line 12` overrides the `choices` method on
  `line 6` in this case because `predict_the_future` is called on a `RoadTrip` object.
  `RoadTrip` inherits from `Oracle`. As such it automatically has access to `predict_the_future`.
  It does, however, define its own `choices` instance method. Ruby's method lookup path checks
  the calling object class first before any of its superclasses. When Ruby sees a `choices`
  method in `RoadTrip` it goes no further and executes that one.

3. You can invoke `#ancestors` on a class to determine the method lookup path Ruby will use
  when an method is invoked on that class or an object of that class. `Orange`'s method lookup
  path is `Orange > Taste > Object > Kernel > BasicObject`. `HotSauce`'s lookup path is
  `HotSauce > Taste > Object > Kernel > BasicObject`.

4. Write `attr_accessor :type` above `initialize`. This will automatically generate a getter
  and a setter for `:@type`.

5. `excited_dog` is a local variable. `@excited_dog` is an instance variable. `@@excited_dog`
  is a class variable. The presence and quantity of `@` in the beginning of a variable name
  denotes its accessibility, which determines the type of variable it is.

6. `manufacturer` is a class method. Adding `self.` as a prefix to the class name in the
  method definition denotes a class method.. Class methods can be called by calling the 
  name of the class followed by the class method as in `Television.manufacturer`.

7. `@@cats_count` is a class variable that represents the number of `Cat` objects
  instantiated. Every time a `Cat` object is instantiated, `initialize` increments 
  `@@cats_count` by 1, as seen on `line 7`. To determine this is true, several `Cat` objects
  have to be instantiated and then `Cat.cats_count` has be invoked.

8. We can add `< Game` to the end of the class name in `Bingo`'s class definition.

9. Ruby's method lookup path will prioritize the method written in `Bingo` over the one written
  in `Game`.

10. Benefits of Object Oriented Programming in Ruby
  1. It allows programmers to think abstractly about their code.
  2. Naming classes after nouns makes the code easier to conceptualize.
  3. It prevents namespacing issues because functionality is only exposed to parts of the
    program that need to see it.
  4. It fascilitates faster code writing because can be reused.
  5. It allows the sharing of similar functionality without duplication.
  6. As code projects get more complex, it assists in organization.
