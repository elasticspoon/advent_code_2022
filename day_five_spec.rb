require_relative 'day_five'

RSpec.describe DayFive do
  describe '#set_crate_state' do
    it 'reads in [D] correctly' do
      test_input = <<~INPUT
      [D]
       1

      move 
      INPUT

      expect(described_class.set_crate_state(test_input)).to eq([['D']])
    end

    it 'reads in two colums correctly' do
      test_input = <<~INPUT
      [D] [N]
       1   2
      
      move
      INPUT

      expect(described_class.set_crate_state(test_input)).to eq([['D'], ['N']])
    end


    xit 'readed in the example input correctly' do
      test_input = <<~INPUT
      [D]        
      [N] [C]    
      [Z] [M] [P]
       1   2   3

      move 1 from 1 to 2
      INPUT

      expect(described_class.set_crate_state(test_input)).to eq([['D', 'N', 'Z'], ['C', 'M'], ['P']])
    end
  end

  describe '#do_operation' do
    let(:boat) { described_class.new(nil) }
    let(:initial_state) { [['D', 'N', 'Z'], ['C', 'M'], ['P']] }

    before do
      allow(DayFive).to receive(:set_crate_state).and_return(initial_state)
    end
    
    it 'moves 1 crate corretly' do
      boat.do_operation('move 1 from 2 to 1')
      expect(boat.crate_state).to eq([['C', 'D', 'N', 'Z'], ['M'], ['P']])
    end
    it 'moves 2 crate corretly' do
      boat.do_operation('move 2 from 2 to 1')
      expect(boat.crate_state).to eq([['M', 'C', 'D', 'N', 'Z'], [], ['P']])
    end
    
  end
  
  describe '#get_top_crates' do
    let(:initial_state) { [['D', 'N', 'Z'], ['C', 'M'], ['P']] }

    it 'returns the top crates' do
      expect(described_class.get_top_crates(initial_state)).to eq('DCP')
    end
  end

  describe '#set_operations' do
    test_input = <<~INPUT
    [V]     [B]                     [C]
    [C]     [N] [G]         [W]     [P]
    [W]     [C] [Q] [S]     [C]     [M]
    [L]     [W] [B] [Z]     [F] [S] [V]
    [R]     [G] [H] [F] [P] [V] [M] [T]
    [M] [L] [R] [D] [L] [N] [P] [D] [W]
    [F] [Q] [S] [C] [G] [G] [Z] [P] [N]
    [Q] [D] [P] [L] [V] [D] [D] [C] [Z]
    1   2   3   4   5   6   7   8   9 

    move 1 from 9 to 2
    move 4 from 6 to 1
    move 2 from 4 to 3
    INPUT

    it 'returns the operations' do
      expect(described_class.get_operations(test_input)).to eq(['move 1 from 9 to 2', 'move 4 from 6 to 1', 'move 2 from 4 to 3'])
    end
  end
end