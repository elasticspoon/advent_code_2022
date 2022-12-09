require_relative 'day_eight'

RSpec.describe DayEight do
  describe '#build_forest' do
    it 'takes a string and outputs a 2d array' do
      forest = DayEight.new.build_forest('1')
      expect(forest).to eq([[Tree.new(1)]])
    end

    it 'fills the 2d array with trees' do
      forest = DayEight.new.build_forest('12')
      expect(forest).to eq([[Tree.new(1), Tree.new(2)]])
    end

    it 'parses multiple lines' do
      forest = DayEight.new.build_forest("123\n123")
      expect(forest).to eq([[Tree.new(1), Tree.new(2), Tree.new(3)], [Tree.new(1), Tree.new(2), Tree.new(3)]])
    end
  end

  describe '#set_visible' do
    it 'sets visible to true if tree is visible' do
      tree_line = DayEight.new.build_forest('1')[0]
      DayEight.new.set_visible(tree_line)
      expect(tree_line.first.visible).to be(true)
    end

    it 'sets visible to false if tree is not visible' do
      tree_line = DayEight.new.build_forest('21')[0]
      DayEight.new.set_visible(tree_line)
      expect(tree_line.last.visible).to be(false)
    end

    it 'sets visible to true if tree is visible behind non visible tree' do
      tree_line = DayEight.new.build_forest('325')[0]
      DayEight.new.set_visible(tree_line)
      tree_line_values = tree_line.map { |tree| tree.visible }
      expect(tree_line_values).to eq([true, false, true])
    end
  end

  describe '#forest_visibility' do
    let(:forest) do
      DayEight.new("30373\n25512\n65332\n33549\n35390")
    end

    it { expect(forest.forest[0][0].visible).to be(true) }
    it { expect(forest.forest[1][1].visible).to be(true) }
    it { expect(forest.forest[1][3].visible).to be(false) }
    it { expect(forest.forest[2][3].visible).to be(true) }
    it { expect(forest.forest[1][1].visible).to be(true) }
    it { expect(forest.forest[1][2].visible).to be(true) }
  end

  describe '#visible_trees' do
    it 'returns the number of visible trees' do
      expect(DayEight.new("30373\n25512\n65332\n33549\n35390").visible_trees).to eq(21)
    end
  end

  describe '#set_scenic_score' do
    let(:forest) do
      forest = DayEight.new("30373\n25512\n65332\n33549\n35390")
      forest.set_scenic_score
      forest
    end

    it 'sets the scenic score of the middle 5 second row tree' do
      expect(forest.forest[1][2].total_scenic_score).to eq(4)
    end

    it 'sets the scenic score of the middle 5 of fourth row tree' do
      forest
      # binding.irb
      expect(forest.forest[3][2].total_scenic_score).to eq(8)
    end
  end
end

RSpec.describe Tree do
  describe '#initialize' do
    it 'returns its height with to_s' do
      expect(Tree.new(1).to_s).to eq('1')
    end

    it 'has method visible' do
      expect { Tree.new(1).visible }.not_to raise_error
    end

    describe '#==' do
      it 'returns true if trees have same height' do
        expect(Tree.new(1)).to eq(Tree.new(1))
      end

      it 'returns false if trees have different height' do
        expect(Tree.new(1)).not_to eq(Tree.new(2))
      end
    end

    describe '#<=>' do
      it 'returns -1 if tree is smaller' do
        expect(Tree.new(1) <=> Tree.new(2)).to eq(-1)
      end

      it 'returns 0 if trees are equal' do
        expect(Tree.new(1) <=> Tree.new(1)).to eq(0)
      end

      it 'returns 1 if tree is larger' do
        expect(Tree.new(2) <=> Tree.new(1)).to eq(1)
      end
    end

    describe '#total_scenic_score' do
      it 'returns 0 if no scenic score' do
        tree = Tree.new(1)
        tree.scenic_score = { ne: 1, nw: 2, se: 3, sw: 4 }
        expect(tree.total_scenic_score).to eq(24)
      end
    end

    describe '#row_scenic_score' do
      let(:forest) do
        DayEight.new("30373\n25512\n65332\n33549\n35390")
      end

      it 'returns 1 if all trees taller than current' do
        tree_line = forest.forest[0]
        tree = Tree.new(1)
        expect(tree.row_scenic_score(tree_line)).to eq(1)
      end

      it 'returns 0 if no trees' do
        tree_line = []
        tree = Tree.new(1)
        expect(tree.row_scenic_score(tree_line)).to eq(0)
      end

      it 'returns 5 if 5 trees in row shorter than it' do
        tree_line = forest.forest[1]
        tree = Tree.new(8)
        expect(tree.row_scenic_score(tree_line)).to eq(5)
      end
    end
  end
end
