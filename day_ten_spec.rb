require_relative 'day_ten'

RSpec.describe CPU do
  let(:cpu) { described_class.new }

  describe '#initialize' do
    it 'has a register' do
      expect(cpu.register).to eq(1)
    end

    it 'has a cycle' do
      expect(cpu.cycle).to eq(1)
    end
  end

  describe '#modify_register' do
    it 'increases the register' do
      cpu.modify_register(4)
      expect(cpu.register).to eq(5)
    end

    it 'decreases the register' do
      cpu.modify_register(-4)
      expect(cpu.register).to eq(-3)
    end
  end

  describe '#increment_cycle' do
    it 'increases the cycle by one' do
      cpu.increment_cycle
      expect(cpu.cycle).to eq(2)
    end
  end

  describe '#execute_noop' do
    it 'does not change register' do
      expect { cpu.execute_noop }.not_to(change(cpu, :register))
    end

    it 'increases the cycle by one' do
      expect { cpu.execute_noop }.to(change(cpu, :cycle).by(1))
    end
  end

  describe '#execute_add' do
    it 'changes register immediatly' do
      expect { cpu.execute_add(4) }.to(change(cpu, :register).by(4))
    end

    it 'increases the cycle by two' do
      expect { cpu.execute_add(4) }.to(change(cpu, :cycle).by(2))
    end
  end

  describe '#execute_instuctions' do
    let(:long_input) do
      File.read('day_ten_sample_input.txt')
    end

    let(:long_history) do
      cpu.execute_instructions(long_input)
      cpu.history
    end

    it 'executes short instructions' do
      input = <<~INPUT
        noop
        addx 3
        addx -5
      INPUT
      cpu.execute_instructions(input)
      expect(cpu.register).to eq(-1)
      expect(cpu.cycle).to eq(6)
    end

    it 'has correct history' do
      input = <<~INPUT
        noop
        addx 3
        addx -5
        noop
      INPUT
      cpu.execute_instructions(input)
      expect(cpu.history).to eq({ 1 => 1, 2 => 1, 3 => 1, 4 => 4, 5 => 4, 6 => -1 })
    end

    context 'when executing long instructions' do
      it { expect(long_history[20]).to eq(21) }
      it { expect(long_history[60]).to eq(19) }
      it { expect(long_history[100]).to eq(18) }
      it { expect(long_history[140]).to eq(21) }
      it { expect(long_history[180]).to eq(16) }
      it { expect(long_history[220]).to eq(18) }

      it 'sums the signal strengths corrently' do
        cpu.execute_instructions(long_input)
        expect(cpu.sum_signal_strs).to eq(13_140)
      end
    end
  end

  describe '#draw_pixel' do
    it 'draws a pixel if cycle is equal to register' do
      cpu.instance_variable_set(:@register, 1)
      cpu.instance_variable_set(:@cycle, 1)
      expect(cpu.draw_pixel).to eq('#')
    end

    it 'draws a pixel if cycle is 1 below register' do
      cpu.instance_variable_set(:@register, 1)
      cpu.instance_variable_set(:@cycle, 0)
      expect(cpu.draw_pixel).to eq('#')
    end

    it 'draws a pixel if cycle is 1 above register' do
      cpu.instance_variable_set(:@register, 1)
      cpu.instance_variable_set(:@cycle, 2)
      expect(cpu.draw_pixel).to eq('#')
    end

    it 'does not draw a pixel if cycle is 2 above register' do
      cpu.instance_variable_set(:@register, 1)
      cpu.instance_variable_set(:@cycle, 3)
      expect(cpu.draw_pixel).to eq('.')
    end

    it 'does not draw a pixel if cycle is 2 below register' do
      cpu.instance_variable_set(:@register, 1)
      cpu.instance_variable_set(:@cycle, -2)
      expect(cpu.draw_pixel).to eq('.')
    end
  end
end
