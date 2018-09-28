require_relative '00_tree_node'
require 'byebug'

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
  attr_accessor :root_node, :visited_pos

  def self.corner_start
    first_move = PolyTreeNode.new([0, 0])
    self.new(first_move)
  end

  def self.valid_moves(pos)
    self.all_moves(pos).select {|move| self.valid?(move)}
  end

  # private
  def self.valid?(pos)
    pos.all? { |coordinate| coordinate.between?(0, 7) }
  end

  def self.all_moves(pos)
    MOVES.map do |coordinate|
      x = coordinate.first + pos.first
      y = coordinate.last + pos.last
      [x, y]
    end
  end

  def initialize(root_node = KnightPathFinder.corner_start)
    @root_node = root_node
    @visited_pos = []
  end

  def build_move_tree
    queue = [self.root_node]
    until queue.empty?
      current_node = queue.first
      self.visited_pos << current_node
      next_positions = KnightPathFinder.valid_moves(current_node.value)
      next_positions.each do |pos|
        next_node = PolyTreeNode.new(pos)
        current_node.add_child(next_node)
        queue << next_node unless self.visited_pos.include?(next_node)
      end
      queue.shift
    end
    self.root_node
  end

  def find_path(end_pos)
    build_move_tree
    search = self.root_node.bfs(end_pos)
    search.nil? ? nil : trace_path_back(search)
  end

  def trace_path_back(end_node)
    path = []
    current_parent = end_node
    until current_parent.nil?
      path.unshift(current_parent.value)
      current_parent = current_parent.parent
    end
    path
  end

end

k = KnightPathFinder.corner_start
p k.build_move_tree
