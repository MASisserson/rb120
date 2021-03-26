# Answers for Practice Problems: Medium 1

1. Ben is right. He set a getter for `:@balance` on `line 2`. 

2. `quantity`, on `line 11`, needs to be changed to `self.quantity` or `@quantity`. Ruby will
  think that `quantity` is a local variable if we don't indicate it is the instance variable
  we are refering to. A setter method needs to be made, `attr_writer :quantity` if we want
  to use `self.quantity`.

3. We would prefer having setter methods hidden from public access so they can't be messed with
  unintentionally. 

4. 
```ruby

class Greeting
  def greet(string)
    puts string
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

```

5. 
```ruby
class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    filling + glaze
  end

  private

  attr_reader :filling_type, :glazing

  def filling
    filling_type ? filling_type : "Plain"
  end

  def glaze
    glazing ? " with #{glazing}" : ''
  end
end
```

6. There is functionally no difference at the moment. If an alternative method were set as the
  setter method, however, the first class definition would already work with it. The second
  sets `:@template` directly so it will not run a setter method that is defined as is. One
  should avoid `self` wherever it is uneccessary.

7. Rename it from `light_status` to `status`
