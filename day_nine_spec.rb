require_relative 'day_nine'

RSpec.describe DayNine do
  describe '#full_test' do
    let(:head) { Head.new }

    it 'executes the full test' do
      test_input = <<~INPUT
        R 4
        U 4
        L 3
        D 1
        R 4
        D 1
        L 5
        R 2
      INPUT
      test_input.split("\n").each do |command|
        head.execute_command(command)
      end

      expect(head.tail.number_of_unique_locations).to eq(13)
    end
  end
end

RSpec.describe Head do
  let(:tail) { Tail.new }
  let(:head) { Head.new(tail) }

  describe '#initialize' do
    it 'responds to position' do
      expect(head).to respond_to(:position)
    end

    it 'responds to tail' do
      expect(head).to respond_to(:tail)
    end

    it 'has initial position of 0, 0' do
      expect(head.position).to eq([0, 0])
    end
  end

  describe '#move' do
    it 'accepts a string as an argument' do
      expect { head.move('U') }.not_to raise_error
    end

    it 'moves up' do
      head.move('U')
      expect(head.position).to eq([0, 1])
    end

    it 'moves down' do
      head.move('D')
      expect(head.position).to eq([0, -1])
    end

    it 'moves left' do
      head.move('L')
      expect(head.position).to eq([-1, 0])
    end

    it 'moves right' do
      head.move('R')
      expect(head.position).to eq([1, 0])
    end
  end

  describe '#execute_command' do
    it 'accepts a string as an argument' do
      expect { head.execute_command('U 3') }.not_to raise_error
    end

    it 'calls move 3 times with U for command "U 3"' do
      expect(head).to receive(:move).exactly(3).times.with('U')
      head.execute_command('U 3')
    end

    it 'command "U 3" ends with head at [0, 3]' do
      head.execute_command('U 3')
      expect(head.position).to eq([0, 3])
    end

    it 'calls follow_head with the new position 3 times' do
      expect(tail).to receive(:follow_head).exactly(3).times
      head.execute_command('U 3')
    end
  end
end

RSpec.describe Tail do
  let(:tail) { Tail.new }

  describe '#initialize' do
    it 'responds to position' do
      expect(tail).to respond_to(:position)
    end

    it 'has initial position of 0, 0' do
      expect(tail.position).to eq([0, 0])
    end
  end

  describe '#follow_head' do
    it 'moves up when head moves up' do
      tail.follow_head([0, 2])
      expect(tail.position).to eq([0, 1])
    end

    it 'moves down when head moves down' do
      tail.follow_head([0, -2])
      expect(tail.position).to eq([0, -1])
    end

    it 'moves left when head moves left' do
      tail.follow_head([-2, 0])
      expect(tail.position).to eq([-1, 0])
    end

    it 'moves right when head moves right' do
      tail.follow_head([2, 0])
      expect(tail.position).to eq([1, 0])
    end

    it 'moves up and right when head moves up and right' do
      tail.follow_head([2, 1])
      expect(tail.position).to eq([1, 1])
    end

    it 'moves up and left when head moves up and left' do
      tail.follow_head([-2, 1])
      expect(tail.position).to eq([-1, 1])
    end

    it 'moves down and right when head moves down and right' do
      tail.follow_head([1, -2])
      expect(tail.position).to eq([1, -1])
    end

    it 'moves down and left when head moves down and left' do
      tail.follow_head([-1, -2])
      expect(tail.position).to eq([-1, -1])
    end

    it 'does not move when head is adjacent' do
      tail.follow_head([1, 1])
      expect(tail.position).to eq([0, 0])
    end
  end
end
