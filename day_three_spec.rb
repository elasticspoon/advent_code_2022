require_relative 'day_three'
RSpec.describe DayThree do
  describe '#split_string' do
    it 'splits the string into 2 equal arrays of characters' do
      string = 'abcd'
      expect(described_class.split_string(string)).to eq([%w[a b], %w[c d]])
    end

    it 'raises an error if the string length is not even' do
      string = 'abc'
      expect { described_class.split_string(string) }.to raise_error(ArgumentError)
    end
  end

  describe '#find_common_character' do
    it 'returns the common character between the two arrays' do
      array1 = %w[a b]
      array2 = %w[b c]
      expect(described_class.find_common_character(array1, array2)).to eq('b')
    end
  end

  describe '#get_item_priority' do
    it 'returns the priority of the item: a' do
      item = 'a'
      expect(described_class.get_item_priority(item)).to eq(1)
    end

    it 'returns the priority of the item: z' do
      item = 'z'
      expect(described_class.get_item_priority(item)).to eq(26)
    end

    it 'returns the priority of the item: A' do
      item = 'A'
      expect(described_class.get_item_priority(item)).to eq(27)
    end

    it 'returns the priority of the item: Z' do
      item = 'Z'
      expect(described_class.get_item_priority(item)).to eq(52)
    end
  end

  describe '#get_sum_priority' do
    it 'returns the sum of the priorities of many rucksacks' do
      test_input = <<~INPUT
        vJrwpWtwJgWrhcsFMMfFFhFp
        jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
        PmmdzqPrVvPwwTWBwg
        wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
        ttgJtRGJQctTZtZT
        CrZsJsPPZsGzwwsLwLmpwMDw
      INPUT

      expect(described_class.get_sum_priority(test_input)).to eq(157)
    end
  end

  describe '#find_badge' do
    it 'returns r for the first example' do
      test_input = %w[
        vJrwpWtwJgWrhcsFMMfFFhFp
        jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
        PmmdzqPrVvPwwTWBwg
      ].map(&:chars)

      expect(described_class.find_badge(test_input)).to eq('r')
    end

    it 'returns Z for the second example' do
      test_input = %w[
        wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
        ttgJtRGJQctTZtZT
        CrZsJsPPZsGzwwsLwLmpwMDw
      ].map(&:chars)

      expect(described_class.find_badge(test_input)).to eq('Z')
    end
  end

  describe '#get_sum_badges' do
    it 'returns the sum of the elf badges' do
      test_input = <<~INPUT
        vJrwpWtwJgWrhcsFMMfFFhFp
        jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
        PmmdzqPrVvPwwTWBwg
        wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
        ttgJtRGJQctTZtZT
        CrZsJsPPZsGzwwsLwLmpwMDw
      INPUT

      expect(described_class.get_sum_badges(test_input)).to eq(70)
    end
  end
end
