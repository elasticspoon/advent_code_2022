require_relative 'day_six'

RSpec.describe DaySix do
  describe '#marker_index' do
    it 'returns 4 when given "abcd"' do
      expect(DaySix.marker_index('abcd')).to eq(4)
    end

    it 'returns 4 when given "abcde"' do
      expect(DaySix.marker_index('abcde')).to eq(4)
    end

    it 'returns 5 when given "aabcdef"' do
      expect(DaySix.marker_index('aabcdef')).to eq(5)
    end

    it 'returns 5 when give input' do
      test_input = 'bvwbjplbgvbhsrlpgdmjqwftvncz'
      expect(DaySix.marker_index(test_input)).to eq(5)
    end

    it 'returns 6 when given test input' do
      test_input = 'nppdvjthqldpwncqszvftbrmjlhg'
      expect(DaySix.marker_index(test_input)).to eq(6)
    end

    it 'returns 10 when given test input' do
      test_input = 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg'
      expect(DaySix.marker_index(test_input)).to eq(10)
    end

    it 'returns 11 when given test input' do
      test_input = 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw'
      expect(DaySix.marker_index(test_input)).to eq(11)
    end

    it 'works with other marker length' do
      test_input = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'
      expect(DaySix.marker_index(test_input, 14)).to eq(19)
    end
  end
end
