require_relative 'day_11'

RSpec.describe DayEleven do
  let(:input) { File.read('day_11_short_sample.txt') }
  let(:setup) { described_class.new(input) }
  let(:worry_setup) { described_class.new(input, worry: true) }

  it 'returns the correct answer for sample input' do
    setup.execute_rounds(20)
    expect(setup.monkey_business).to eq(10_605)
  end

  it 'returns the correct answer for part 2' do
    worry_setup.execute_rounds(10_000)
    expect(worry_setup.monkey_business).to eq(2_713_310_158)
  end

  it 'correct after 1 rounds' do
    # worry_setup.monkeys.each { |m| puts m.inspect }
    worry_setup.execute_rounds(1)
    expect(worry_setup.monkey_inspections).to eq([2, 4, 3, 6])
  end

  it 'correct after 20 rounds' do
    worry_setup.execute_rounds(20)
    expect(worry_setup.monkey_inspections).to eq([99, 97, 8, 103])
  end

  it 'corrent after 1000 rounds' do
    worry_setup.execute_rounds(1000)
    expect(worry_setup.monkey_inspections).to eq([5204, 4792, 199, 5192])
  end
end

RSpec.describe Monkey do
  let(:default_input) do
    input = <<~INPUT
      Monkey 0:
        Starting items: 79, 98
        Operation: new = old * 19
        Test: divisible by 23
          If true: throw to monkey 2
          If false: throw to monkey 3
    INPUT
    input
  end

  let(:monkey) { described_class.new(default_input) }

  context 'with default params' do
    it 'its items are 79 and 98' do
      expect(monkey.items).to eq([79, 98])
    end

    it 'targets are 2 if true and 3 if false' do
      expect(monkey.targets).to eq({ true => 2, false => 3 })
    end

    it 'has a divisor value of 23' do
      expect(monkey.divisor).to eq(23)
    end

    it 'operation when called with 1 returns 19' do
      expect(monkey.operation.call(1)).to eq(19)
    end
  end

  describe 'parse_items' do
    it 'returns an array of items' do
      input = 'Starting items: 79, 80, 55'
      expect(monkey.parse_items(input)).to eq([79, 80, 55])
    end

    it 'returns an empty array if no items' do
      items = 'Starting items:'
      expect(monkey.parse_items(items)).to eq([])
    end
  end

  describe 'parse_targets' do
    it 'returns a hash of targets' do
      input = ['If true: throw to monkey 5', 'If false: throw to monkey 3']
      expect(monkey.parse_targets(input)).to eq({ true => 5, false => 3 })
    end
  end

  describe 'parse_operation' do
    it 'returns a block' do
      input = 'Operation: new = old * 19'
      result = monkey.parse_operation(input).call(1)
      expect(result).to eq(19)
    end
  end

  describe 'parse_divisor' do
    it 'returns a divisor' do
      input = 'Test: divisible by 14'
      expect(monkey.parse_divisor(input)).to eq(14)
    end
  end

  describe 'catch_item' do
    it 'adds item to items' do
      # intial_items = [79, 98]
      expected_items = [79, 98, 1]
      monkey.catch_item(1)
      expect(monkey.items).to eq(expected_items)
    end
  end

  describe 'throw_item' do
    let(:other_monkey) { described_class.new(default_input) }

    it 'monkey 1 losses item 1' do
      monkey.throw_item(other_monkey)
      expect(monkey.items).to eq([98])
    end

    it 'monkey 2 gains item 1' do
      monkey.throw_item(other_monkey)
      expect(other_monkey.items).to eq([79, 98, 79])
    end
  end

  describe 'modify_item' do
    it 'returns the result of the operation divided by 3' do
      expect(monkey.modify_item(1)).to eq(6)
    end
  end

  describe 'execute turn' do
    let(:monkeys) { Array.new(4) { described_class.new(default_input) } }

    it 'monkey 1 throws both items' do
      monkeys[0].execute_turn(monkeys)
      expect(monkeys[0].items).to eq([])
    end

    it 'monkey 3 recives both items' do
      monkeys[0].execute_turn(monkeys)
      expect(monkeys[3].items).to eq([79, 98, 500, 620])
    end

    it 'does nothing if no items' do
      allow(monkeys[1]).to receive(:items).and_return([])
      monkeys[1].execute_turn(monkeys)
      expect(monkeys[1].num_inspections).to eq(0)
    end
  end

  describe 'throw_target' do
    it 'returns the target monkey if false' do
      expect(monkey.throw_target(1)).to eq(3)
    end

    it 'returns the target monkey if true' do
      expect(monkey.throw_target(23)).to eq(2)
    end
  end
end
