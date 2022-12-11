class DayEleven
  attr_reader :monkeys, :worry

  def initialize(input, worry: false)
    @worry = worry
    @monkeys = parse_input(input)
    lcm = find_lcm
    monkeys.each { |monkey| monkey.set_lcm(lcm) }
  end

  def execute_rounds(num_rounds)
    num_rounds.times do
      execute_round
    end
  end

  def execute_round
    monkeys.each_with_index do |monkey, _index|
      monkey.execute_turn(monkeys)
    end
  end

  def parse_input(input)
    input.split("\n\n").map do |monkey|
      Monkey.new(monkey, worry:)
    end
  end

  def monkey_inspections
    monkeys.map(&:num_inspections)
  end

  def monkey_business
    monkey_inspections.max(2).inject(:*)
  end

  def find_lcm
    monkeys.map(&:divisor).reduce(:lcm)
  end
end

class Monkey
  attr_reader :number, :items, :targets, :divisor, :operation, :num_inspections, :worry, :lcm

  def initialize(input, worry: false)
    items, operation, divisor, *targets = parse_input(input)
    @items = parse_items(items)
    @operation = parse_operation(operation)
    @divisor = parse_divisor(divisor)
    @targets = parse_targets(targets)
    @num_inspections = 0
    @worry = worry
  end

  def set_lcm(lcm)
    @lcm = lcm
  end

  def parse_items(input)
    input.scan(/\d+/).map(&:to_i)
  end

  def parse_targets(input)
    true_tar, false_tar = input.map { |v| v.split.last.to_i }
    { true => true_tar, false => false_tar }
  end

  def parse_divisor(input)
    input.split.last.to_i
  end

  def parse_operation(input)
    operation = input.split('=').last.strip

    eval "lambda { |old| #{operation} }"
  end

  def catch_item(item)
    @items << item
  end

  def parse_input(input)
    input.split("\n")[1..].map(&:strip)
  end

  def throw_item(other_monkey)
    item = @items.shift
    other_monkey.catch_item(item)
  end

  def modify_item(item)
    @num_inspections += 1
    operated_value = operation.call(item.to_i)
    worry ? operated_value % lcm : operated_value / 3
  end

  def throw_target(item)
    divisible = item % divisor == 0
    targets[divisible]
  end

  def execute_turn(monkeys)
    while items.any?
      item = items.shift
      modified_item = modify_item(item)
      target = throw_target(modified_item)

      monkeys[target].catch_item(modified_item)
    end
  end
end

File.open('day_11_input.txt') do |file|
  input = file.read
  setup = DayEleven.new(input)
  worry_setup = DayEleven.new(input, worry: true)
  setup.execute_rounds(20)
  worry_setup.execute_rounds(10_000)
  puts setup.monkey_business
  puts worry_setup.monkey_business
end
