class DaySix
  def self.marker_index(string, marker_length=4)
    chars = string.chars
    test_string = chars[...marker_length]
    index = marker_length

    until test_string.uniq!.nil?
      chars.shift
      test_string = chars[...marker_length]
      index += 1
    end

    index
  end
end

File.open('day_six_input.txt') do |file|
  input = file.read
  puts DaySix.marker_index(input)
  puts DaySix.marker_index(input, 14)
end
