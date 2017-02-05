require_relative 'node'

class BinarySearchTree

  def initialize(root)
    @root = root
    @movies = 0
  end

  def insert(root, node)
    currNode = root

    if node.rating > currNode.rating
      if currNode.right == nil
        currNode.right = node
        currNode.right.parent = currNode
      else
        return insert(currNode.right, node)
      end
    elsif node.rating < currNode.rating
      if currNode.left == nil
        currNode.left = node
        currNode.left.parent = currNode
      else
        return insert(currNode.left, node)
      end
    else
      return "error, no duplicate ratings"
    end
  end

  # Recursive Depth First Search
  def find(node, target)
    visited = []
    # check node
    return node if node.title == target
    visited.push(node)
    #check for right child
    if node.right != nil
      find(node.right, target)
    # check for left child
    elsif node.left != nil
      find(node.left, target)
    # move back up the tree
    elsif
      until node.parent.left != nil || node.parent == nil do
        node = node.parent
      end
      find(node.parent.left, target)
    end
  end

  def delete(root, data)
    found = find(root, data)
    if found.left != nil
      if found.parent.right == found
        found.parent.right = found.left
      else
        found.parent.left = found.left
      end
      if found.right != nil
        found.right.parent = found.left
        found.left.right = found.right
      end
    elsif found.right != nil
      found.right.parent = found.parent
      if found.parent.right == found
        found.parent.right = found.right
      else
        found.parent.left = found.right
      end
    else

    end
    found = nil
  end

  # Recursive Breadth First Search
  def printf(children=nil)
    queue = []
    queue.push(@root)

    while queue.size != 0
      n = queue.shift
      puts "#{n.title}: #{n.rating}"
      # n.children.each do |child|
      #   queue.push(child)
      # end
    end
  end
end
