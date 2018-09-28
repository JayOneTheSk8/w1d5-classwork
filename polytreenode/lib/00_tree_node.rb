require 'byebug'
class PolyTreeNode
  attr_reader :value, :parent
  attr_accessor :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    return reset_parent if new_parent.nil?
    @parent.nil? ? @parent = new_parent : reassign_parent(new_parent)
    new_parent.children << self unless new_parent.children.include?(self)
  end

  def reset_parent
    @parent.children.delete(self)
    @parent = nil
  end

  def reassign_parent(new_parent)
    @parent.children.delete(self)
    @parent = new_parent
  end

  def add_child(child)
    self.children << child
    child.parent = self
  end

  def remove_child(child)
    self.children.delete(child)
    child.parent = nil
  end

  def dfs(target)
    return self if self.value == target
    self.children.each do |child|
      current_node  = child.dfs(target)
      return current_node unless current_node.nil?
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      if queue.first.value == target
        return queue.first
      end
      current_parent = queue.shift
      queue += current_parent.children
    end
    nil
  end
end
