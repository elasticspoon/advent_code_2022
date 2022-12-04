class DayThree
  def self.split_string(string)
    raise ArgumentError unless string.length.even?

    string.chars.each_slice(string.length / 2).to_a
  end

  def self.find_common_character(array1, array2)
    (array1 & array2).first
  end

  def self.get_item_priority(item)
    case item
    when 'a'..'z'
      item.ord - 96
    when 'A'..'Z'
      item.ord - 64 + 26
    end
  end

  def self.get_sum_priority(input)
    input.split("\n").sum do |line|
      array1, array2 = split_string(line)
      get_item_priority(find_common_character(array1, array2))
    end
  end

  def self.find_badge(array_input)
    elf_one, elf_two, elf_three = array_input
    elf_one.intersection(elf_two, elf_three).first
  end

  def self.get_sum_badges(input)
    input.split("\n").map(&:chars).each_slice(3).sum do |elf_group|
      get_item_priority(find_badge(elf_group))
    end
  end
end

File.open('day_three_input.txt') do |file|
  input = file.read
  puts DayThree.get_sum_priority(input)
  puts DayThree.get_sum_badges(input)
  #  puts DayOne.top_three_elves(input)
end
