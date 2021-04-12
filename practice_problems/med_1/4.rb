# Circular Queue

class CircularQueue
  attr_accessor :queue, :positions

  def initialize(size)
    @queue = Array.new(size)
    @positions = create_positions_array
  end

  def enqueue(value)
    @queue[positions.first] = value
    shift_position
  end

  def dequeue
    position = nonil_search
    return nil if position.nil?
    value = queue[position]
    queue[position] = nil
    value
  end

  private

  def shift_position
    positions << positions.shift
  end

  def nonil_search
    positions.each do |position|
      return position if !queue[position].nil?
    end
    nil
  end

  def create_positions_array
    counter = -1
    @queue.map { |_| counter += 1 }
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
