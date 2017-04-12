require 'byebug'

class PolyTreeNode
  attr_reader :value, :parent
  attr_accessor :children

  def initialize(value = nil)
    @value = value
    @parent = nil
    @children = []
  end

  def children
    @children.dup
  end

  def parent=(node)
    if self.parent
      parent._children.delete(self)
    end

    @parent = node
    self.parent._children << self unless self.parent.nil?
  end

  def _children
    @children
  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    node.parent = nil
    raise "error" unless node.parent
  end

  def dfs(target)
    return self if self.value == target

    self.children.each do |child|
      x = child.dfs(target)
      return x unless x.nil?
    end

    nil
  end

  def bfs(target)
    array = [self]

    until array.empty?
      child = array.shift

      return child if child.value == target
      array.concat(child.children)
    end

    nil
  end
end
