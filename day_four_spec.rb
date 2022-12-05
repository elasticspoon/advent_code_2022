require_relative 'day_four'

RSpec.describe DayFour do
  describe '#big_contains_small' do
    it { expect(described_class.big_contains_small?(big: [1, 2], small: [3, 4])).to be(false) }
    it { expect(described_class.big_contains_small?(big: [1, 3], small: [3, 4])).to be(false) }
    it { expect(described_class.big_contains_small?(big: [1, 4], small: [3, 4])).to be(true) }
  end

  describe '#ranges_encompass' do
    it { expect(described_class.ranges_encompass?('1-2,3-4')).to be(false) }
    it { expect(described_class.ranges_encompass?('1-3,3-4')).to be(false) }
    it { expect(described_class.ranges_encompass?('1-4,3-4')).to be(true) }
    it { expect(described_class.ranges_encompass?('3-4,1-2')).to be(false) }
    it { expect(described_class.ranges_encompass?('3-4,1-3')).to be(false) }
    it { expect(described_class.ranges_encompass?('3-4,1-4')).to be(true) }
  end

  describe '#num_encompassed' do
    it 'returns 2 for the example input' do
      test_input = <<~INPUT
        2-4,6-8
        2-3,4-5
        5-7,7-9
        2-8,3-7
        6-6,4-6
        2-6,4-8
      INPUT

      expect(described_class.num_encompassed(test_input)).to eq(2)
    end
  end

  describe '#ranges_overlap' do
    it { expect(described_class.ranges_overlap?('1-2,3-4')).to be(false) }
    it { expect(described_class.ranges_overlap?('1-3,3-4')).to be(true) }
    it { expect(described_class.ranges_overlap?('1-4,3-4')).to be(true) }
    it { expect(described_class.ranges_overlap?('3-4,1-2')).to be(false) }
    it { expect(described_class.ranges_overlap?('3-4,1-3')).to be(true) }
    it { expect(described_class.ranges_overlap?('3-4,1-4')).to be(true) }
  end

  describe '#num_overlap' do
    it 'returns 2 for the example input' do
      test_input = <<~INPUT
        2-4,6-8
        2-3,4-5
        5-7,7-9
        2-8,3-7
        6-6,4-6
        2-6,4-8
      INPUT

      expect(described_class.num_overlap(test_input)).to eq(4)
    end
  end
end
