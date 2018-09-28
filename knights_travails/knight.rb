require_relative '00_tree_node'

MOVES = [
  [1, 2],
  [-1, 2],
  [1, -2],
  [-1, -2],
  [2, 1],
  [-2, 1],
  [2, -1],
  [-2, -1]
]

class KnightPathFinder

  def self.root_node
    first_move = PolyTreeNode.new([0, 0])
    self.new(first_move)
  end

  def initialize(start_pos = KnightPathFinder.root_node)
    @start_pos = start_pos
  end

  def valid_move?(move)
    
  end
end
