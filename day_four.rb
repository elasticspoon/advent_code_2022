class DayFour
  def self.big_contains_small?(big:, small:)
    big.first <= small.first && big.last >= small.last
  end

  def self.ranges_overlap?(input)
    a, b, c, d = input.split(',').flat_map { |range| range.split('-').map(&:to_i) }
    ((a..b).to_a & (c..d).to_a).any?
  end

  def self.ranges_encompass?(input)
    range1, range2 = input.split(',').map { |range| range.split('-').map(&:to_i) }
    big_contains_small?(big: range1, small: range2) || big_contains_small?(big: range2, small: range1)
  end

  def self.num_encompassed(input)
    input.split("\n").count { |line| ranges_encompass?(line) }
  end

  def self.num_overlap(input)
    input.split("\n").count { |line| ranges_overlap?(line) }
  end
end

File.open('day_four_input.txt') do |file|
  input = file.read
  puts DayFour.num_encompassed(input)
  puts DayFour.num_overlap(input)
end
