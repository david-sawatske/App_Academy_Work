## Abstract Data Type (ADT)
# => Promises certain functionality, independent of implementation

# Sets - a collection of unique objects
# => Three operations Include?, Set <<, Delete
# a set can be implemented with an array if you don't include duplicates
# => in the case above, you would say the array implements the set (an ADT)
# same can be done with hashes with unique keys and values of true

# Map/ Dictionary
# => Three operations Set (key, value), Get(key), Delete(key)
# => Hash map is the most common example of implementation
# => Array can be used, but is ineffecient

# Why are ADTs important? Certain algos require specific ADTs

# Stacks - LIFO, supports Push and Pop, implemented with an array
# => Recursion uses a stack to keep track of stack frames

# Queue - FIFO, enqueue (first in) and dequeue (last in)

# Tree -
# => bianary tree, made of nodes or verticies
#   => has at most 2 children (bianary) and 1 or 0 parent
#   => node on ternary tree has at most 3 children
#   => n-ary/ poly tree has up to unlimited children per node
# => the root of the tree is at the top
# => leaves are at the bottom layer
# => depth or height of tree == deepest pash, root to a leaf node

#      Tree
#        1
#     2      3
#   4   5  6   7

# Traversing a tree
# => BFS - breadth first (layer by layer) 1,2,3,4,5,6,7
#  => Requires a queue


# => DFS - depth first 4,5,2,6,7,3,1
#   => runs straight to the bottom
#   => implemented using recursion
#    => on left sub tree, on right sub tree or does not exist

def dfs(root, target)
  return root if root.value == target
  root.children.each do |child|
    search_result = dfs(child, target)
    return search_result unless search_result.nil?
  end

  nil
end
