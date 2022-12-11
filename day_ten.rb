class CPU
  attr_reader :register, :cycle, :history, :drawing

  def initialize
    @register = 1
    @cycle = 1
    @history = {}
    @drawing = ''
  end

  def modify_register(value)
    @register += value
  end

  def increment_cycle
    # puts 'incremented'
    @history[cycle] = register
    @drawing += draw_pixel
    @cycle += 1
  end

  def execute_noop
    increment_cycle
  end

  def execute_add(value)
    increment_cycle
    increment_cycle
    modify_register(value)
  end

  def execute_command(input)
    command, value = input.split
    value = value.to_i
    case command
    when 'noop'
      execute_noop
    when 'addx'
      execute_add(value)
    end
  end

  def execute_instructions(input)
    input.each_line do |line|
      execute_command(line)
    end
  end

  def signal_strength(cycle)
    cycle * history[cycle]
  end

  def sum_signal_strs
    6.times.sum { |i| signal_strength((i * 40) + 20) }
  end

  def draw_pixel
    if (register - ((cycle - 1) % 40)).abs <= 1
      '#'
    else
      '.'
    end
  end

  def show_drawing
    drawing.each_char.each_slice(40).each do |row|
      puts row.join
    end
  end
end

File.open('day_ten_input.txt') do |file|
  input = file.read
  cpu = CPU.new
  cpu.execute_instructions(input)
  puts cpu.sum_signal_strs
  cpu.show_drawing
end
