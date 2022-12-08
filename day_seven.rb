require 'forwardable'
class DaySeven
  attr_reader :current_directory, :head

  def initialize
    @head = FileDirectory.new('/', nil)
    @current_directory = @head
  end

  def change_directory(path)
    if path == '..'
      @current_directory = current_directory.parent
    elsif path == '/'
      @current_directory = @head
    else
      @current_directory = current_directory.find { |item| item.name == path }
    end
  end

  def populate_directory(input)
    file_size, file_name = input.split(' ')

    if file_size == 'dir'
      @current_directory << FileDirectory.new(file_name, current_directory)
    else
      @current_directory << ElfFile.new(file_name, file_size.to_i)
    end
  end

  def computer_state
    @head.to_s
  end

  def build_file_structure(input)
    input.each_line do |line|
      marker, *operation = line.split(' ')

      if marker == '$'
        execute_operation(operation)
      else
        populate_directory(line)
      end
    end
  end

  def execute_operation(operation)
    if operation[0] == 'cd'
      change_directory(operation[1])
    end
  end

  def clean_space(total_size, needed_space)
    dirs = head.dir_sizes.sort
    used_space = dirs.last
    space_to_clear = used_space + needed_space - total_size
    puts "space to clear: #{space_to_clear}"

    clearable_dirs = dirs.select { |dir| dir > space_to_clear }
    clearable_dirs.first
  end

end

class FileDirectory
  attr_reader :name, :items, :parent
  extend Forwardable
  def_delegators :@items, :<<, :push, :pop, :find

  def initialize(name, parent)
    @name = name
    @parent = parent
    @items = []
  end

  def size
    @items.map(&:size).reduce(:+)
  end

  def size_smaller_than(size)
    subd_size = @items.map { |item| item.size_smaller_than(size) }.reduce(:+)
    return self.size < size ? self.size + subd_size: subd_size
  end

  def dir_sizes
      [self.size] + @items.map(&:dir_sizes).flatten

  end

  def to_s(level: 0)
    child_data = @items.map { |item| item.to_s(level: level + 1) }.join("\n")
    
    self_state = "- #{@name} (dir)".prepend('  ' * level)
    
    child_data == '' ? self_state : [self_state, child_data].join("\n")
  end
end

class ElfFile
  attr_reader :name, :size

  def initialize(name, size)
    @name = name
    @size = size
  end

  def to_s(level: 0)
    "- #{@name} (file, size=#{@size})".prepend('  ' * level)
  end

  def size_smaller_than(size)
    0
  end

  def dir_sizes
    []
  end
end


File.open('day_seven_input.txt') do |file|
  input = file.read
  computer = DaySeven.new
  computer.build_file_structure(input)
  # puts computer.computer_state
  # puts computer.head.size_smaller_than(100000)
  puts computer.clean_space(70000000, 30000000)
end