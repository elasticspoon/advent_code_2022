class DayOne
  def self.max_elf_calories(string_input)
    elf_calories = string_input.split("\n\n").map do |string|
      string.split("\n").sum(&:to_i)
    end

    elf_calories.max
    # indexed_elves = split_strings.each_with_index.with_object({}) do |elf_data, hash|
    #   elf, index = elf_data
    #   elf_total = elf.split("\n").sum(&:to_i)
    #   hash[index + 1] = elf_total
    # end

    # indexed_elves.max_by do |_index, elf|
    #   elf
    # end.first
  end

  def self.top_three_elves(string_input)
    elf_calories = string_input.split("\n\n").map do |string|
      string.split("\n").sum(&:to_i)
    end

    elf_calories.sort.last(3).sum
  end
end

File.open('day_one_input.txt') do |file|
  input = file.read
  puts DayOne.max_elf_calories(input)
  puts DayOne.top_three_elves(input)
end
