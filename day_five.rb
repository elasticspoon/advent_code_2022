class DayFive

  attr_reader :crate_state

  def initialize(input)
    @crate_state = DayFive.set_crate_state(input)
    @operations = DayFive.get_operations(input)
  end
  
  def self.get_top_crates(crate_state)
    crate_state.map{ |x| x.first || ''}.join
  end

  def self.get_operations(input)
    input.split("\n\n").last.split("\n")
  end
  
  def self.set_crate_state(input)
    chars = input.split("\n\n").first.split("\n")[...-1].map(&:chars)
    
    cols = chars.map do |row| 
      row.each_with_index.filter_map do |char, index|
        char if index % 4 == 1
      end
    end
    
    cols.transpose.each { |col| col.delete(' ')}
  end

  def do_operation(operation, reverse: false)
    operation = operation.split(' ')
    crates_num = operation[1].to_i
    from = operation[3].to_i
    to = operation[5].to_i

    moved_crates = @crate_state[from - 1].shift(crates_num)
    reverse ? moved_crates.reverse! : moved_crates

    @crate_state[to - 1].unshift(*moved_crates)
  end

  def do_operations_reverse
    @operations.each { |operation| do_operation(operation, reverse: true) }
    puts DayFive.get_top_crates(@crate_state).inspect
  end

  def do_operations
    @operations.each { |operation| do_operation(operation, reverse: false) }
    puts DayFive.get_top_crates(@crate_state).inspect
  end

end

File.open('day_five_input.txt') do |file|
  content = file.read
  boat = DayFive.new(content)
  boat.do_operations_reverse
  boat = DayFive.new(content)
  boat.do_operations

end