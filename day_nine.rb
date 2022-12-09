class DayNine
end

class Head
  attr_accessor :position
  attr_reader :tail

  def initialize(tail=Tail.new)
    @position = [0, 0]
    @tail = tail
  end

  def move(direction)
    case direction
    when 'U'
      @position[1] += 1
    when 'D'
      @position[1] -= 1
    when 'L'
      @position[0] -= 1
    when 'R'
      @position[0] += 1
    end
  end

  def execute_command(command)
    direction, distance = command.split
    distance.to_i.times do
      move(direction)
      tail.follow_head(position)
    end
  end
end

class Tail
  attr_reader :position, :position_history, :tail

  def initialize(tail: nil)
    @position = [0, 0]
    @position_history = { [0, 0] => true }
    @tail = tail
  end

  def follow_head(head_location)
    x_delta = head_location[0] - @position[0]
    y_delta = head_location[1] - @position[1]

    tail_move(x_delta, y_delta) if x_delta.abs > 1 || y_delta.abs > 1

    @position_history[@position.clone] ||= true
    tail&.follow_head(@position)
    # puts "Head is a #{head_location} Tail is at #{@position}"
  end

  def tail_move(x_delta, y_delta)
    if x_delta.zero? || y_delta.zero?
      @position[0] += x_delta / 2
      @position[1] += y_delta / 2
    else
      @position[0] += x_delta > 0 ? 1 : -1
      @position[1] += y_delta > 0 ? 1 : -1
    end
  end

  def set_tail(tail)
    @tail = tail
  end

  def number_of_unique_locations
    @position_history.keys.length
  end
end

File.open('day_nine_input.txt') do |file|
  input = file.read
  head = Head.new
  other_head = Head.new
  temp = other_head.tail
  8.times do
    temp.set_tail(Tail.new)
    temp = temp.tail
  end

  input.split("\n").each do |command|
    head.execute_command(command)
    other_head.execute_command(command)
  end
  puts head.tail.number_of_unique_locations
  puts temp.number_of_unique_locations
end
