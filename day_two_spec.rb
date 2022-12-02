require_relative 'day_two'
RSpec.describe DayTwo do
  describe '#move_score' do
    it 'returns 1 if you play rock' do
      expect(described_class.move_score('X')).to eq(1)
    end

    it 'returns 2 if you play paper' do
      expect(described_class.move_score('Y')).to eq(2)
    end

    it 'returns 3 if you play scissors' do
      expect(described_class.move_score('Z')).to eq(3)
    end
  end

  describe '#outcome_score' do
    it { expect(described_class.outcome_score('A', 'X')).to eq(3) }
    it { expect(described_class.outcome_score('A', 'Y')).to eq(6) }
    it { expect(described_class.outcome_score('A', 'Z')).to eq(0) }
    it { expect(described_class.outcome_score('B', 'X')).to eq(0) }
    it { expect(described_class.outcome_score('B', 'Y')).to eq(3) }
    it { expect(described_class.outcome_score('B', 'Z')).to eq(6) }
    it { expect(described_class.outcome_score('C', 'X')).to eq(6) }
    it { expect(described_class.outcome_score('C', 'Y')).to eq(0) }
    it { expect(described_class.outcome_score('C', 'Z')).to eq(3) }
  end

  describe '#round_score' do
    it 'returns 8 when round is A Y' do
      expect(described_class.round_score('A', 'Y')).to eq(8)
    end

    it 'returns 1 when round is B X' do
      expect(described_class.round_score('B', 'X')).to eq(1)
    end

    it 'returns 6 when round is C Z' do
      expect(described_class.round_score('C', 'Z')).to eq(6)
    end
  end

  describe '#play game' do
    it 'loops over multiple rounds' do
      test_input = <<~INPUT
        A Y
        B X
        C Z
      INPUT

      expect(described_class.play_game(test_input)).to eq(15)
    end
  end

  describe '#expected_shape' do
    it { expect(described_class.expected_shape('A', 0)).to eq('Z') }
    it { expect(described_class.expected_shape('A', 3)).to eq('X') }
    it { expect(described_class.expected_shape('A', 6)).to eq('Y') }
    it { expect(described_class.expected_shape('B', 0)).to eq('X') }
    it { expect(described_class.expected_shape('B', 3)).to eq('Y') }
    it { expect(described_class.expected_shape('B', 6)).to eq('Z') }
    it { expect(described_class.expected_shape('C', 0)).to eq('Y') }
    it { expect(described_class.expected_shape('C', 3)).to eq('Z') }
    it { expect(described_class.expected_shape('C', 6)).to eq('X') }
  end

  describe '#real_round_score' do
    it 'returns 4 when round is A Y' do
      expect(described_class.real_round_score('A', 'Y')).to eq(4)
    end

    it 'returns 1 when round is B X' do
      expect(described_class.real_round_score('B', 'X')).to eq(1)
    end

    it 'returns 7 when round is C Z' do
      expect(described_class.real_round_score('C', 'Z')).to eq(7)
    end
  end

  describe '#play_full_game' do
    it 'returns 12 when input is A Y B X C Z' do
      test_input = <<~INPUT
        A Y
        B X
        C Z
      INPUT

      expect(described_class.play_full_game(test_input)).to eq(12)
    end
  end
end
