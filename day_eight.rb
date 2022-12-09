class DayEight

  attr_reader :forest

  def initialize(input = '')
    @forest = build_forest(input)
    @transposed_forest = @forest.transpose
    forest_visibility
  end


  def build_forest(string)
    string.split("\n").map do |tree_line| 
      tree_line.split('').map { |height| Tree.new(height.to_i)}
    end
  end

  def set_visible(tree_line)
    tallest_tree = tree_line.first.height - 1
    tree_line.each do |tree|
      tree.visible ||= tree.height > tallest_tree
      tallest_tree = tree.height if tree.height > tallest_tree
    end
  end

  def forest_visibility
    forest.each do |tree_line| 
      set_visible(tree_line)
      set_visible(tree_line.reverse)
     end
    @transposed_forest.each do |tree_line|
      set_visible(tree_line)
      set_visible(tree_line.reverse)
    end
  end

  def visible_trees
    forest.flatten.count { |tree| tree.visible }
  end

  def most_scenic_tree
    forest.flatten.max_by { |tree| tree.total_scenic_score }.total_scenic_score
  end

  def set_scenic_score
    forest.each do |tree_line|
      tree_line.each_with_index do |tree, index|
        before = tree_line[...index]
        after = tree_line[(index + 1)...]
        tree.scenic_score[:ew] = tree.row_scenic_score(after)
        tree.scenic_score[:we] = tree.row_scenic_score(before.reverse)
      end
    end
    @transposed_forest.each do |tree_line|
      tree_line.each_with_index do |tree, index|
        before = tree_line[...index]
        after = tree_line[(index + 1)...]
        tree.scenic_score[:ns] = tree.row_scenic_score(after)
        tree.scenic_score[:sn] = tree.row_scenic_score(before.reverse)
      end
    end
  end
end

class Tree
  attr_reader :height
  attr_accessor :visible, :scenic_score

  def initialize(height)
    @height = height
    @visible = nil
    @scenic_score = {ns: 0, ew: 0, sn: 0, we: 0}
  end

  def to_s
    @height.to_s
  end

  def ==(other)
    height == other.height
  end

  def <=>(other)
    height <=> other.height
  end

  def row_scenic_score(tree_line)
    taller_tree_index = tree_line.index { |tree| tree.height >= height }
    taller_tree_index ? taller_tree_index + 1 : tree_line.length
  end

  def set_scenic_score(tree_line, direction)
    @scenic_score[direction] = row_scenic_score(tree_line)
  end

  def total_scenic_score
    scenic_score.values.inject(:*)
  end
end

File.open('day_eight_input.txt') do |file|
  input = file.read
  forest = DayEight.new(input)
  puts forest.visible_trees
  forest.set_scenic_score
  puts forest.most_scenic_tree
end