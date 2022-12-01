require_relative 'day_one'
RSpec.describe DayOne do
  describe '#max_elf' do
    it 'returns elf with most food' do
      test_input = <<~INPUT
        1000
        2000
        3000

        4000

        5000
        6000

        7000
        8000
        9000

        10000
      INPUT

      expect(DayOne.max_elf_calories(test_input)).to eq(24_000)
    end

    it 'returns 1 if only one elf' do
      test_input = '1000'

      expect(DayOne.max_elf_calories(test_input)).to eq(1000)
    end

    it 'returns 1 if elf one has most food' do
      test_input = <<~INPUT
        3000

        1000
      INPUT

      expect(DayOne.max_elf_calories(test_input)).to eq(3000)
    end

    it 'returns 2 if elf two has most food' do
      test_input = <<~INPUT
        1000

        3000
      INPUT

      expect(DayOne.max_elf_calories(test_input)).to eq(3000)
    end

    it 'sums food for each elf' do
      test_input = <<~INPUT
        1000
        2000


        4000
        5000
      INPUT

      expect(DayOne.max_elf_calories(test_input)).to eq(9000)
    end
  end
end
