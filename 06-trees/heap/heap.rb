require_relative 'node'

class Heap

  def initialize(root)
    @root = root
  end

  def insert(root, node)
    placed = nil
    if root == @root
      children = [root]
    else
      children = root
    end
    nextRow = []
    children.each do |child|
      # if not empty, add left child to search queue
      if child.left == nil
        child.left = node
        child.left.parent = child
        placed = child.left
      # if not emptry, add right child to search queue
      elsif child.right == nil
        child.right = node
        child.right.parent = child
        placed = child.right
      else
        nextRow.push(child.left)
        nextRow.push(child.right)
      end
    end
    if placed != nil
      order(placed)
    else
      insert(nextRow, node)
    end
  end

  def order(node)
    if node != @root
      puts "ordering non-root"
      if node.rating < node.parent.rating
        # connect parent's parent to node
        if node.parent == @root
            puts "root's child"
            node.parent = nil
        else
          if node.parent.parent.right == node.parent
            node.parent.parent.right = node
          else
            node.parent.parent.left = node
          end
        end
        # connect other child to node in new position
        if node.parent.left == node
          node.parent.right.parent = node if node.parent.right != nil
        else
          node.parent.left.parent = node if node.parent != nil
        end
        # place old parent as child of node
        node.parent.parent = node
        order(node)
      end
    end
  end

  # Recursive Depth First Search
  def find(node, target)
    if node == nil
      return nil
    elsif node.title == target
      return node
    else
      x = find(node.right, target)
      y = find(node.left, target)
      if x != nil
        return x
      elsif y != nil
        return y
      else
        return nil
      end
    end
  end

  def delete(root, data)
    found = find(root, data)
    return nil if found == nil
    # move the left child to take deleted node's place
    if found.left != nil
      # connect deleted node's parent to new child
      if found.parent.right == found
        found.parent.right = found.left
      else
        found.parent.left = found.left
      end
      # connect deleted node's other child to new parent
      if found.right != nil
        found.right.parent = found.left
        found.left.right = found.right
      end
      # connect left node to new parent
      found.left.parent = found.parent
    # move right child to take deleted node's place if no left child
    elsif found.right != nil
      # connect deleted node's parent to new child
      if found.parent.right == found
        found.parent.right = found.right
      else
        found.parent.left = found.right
      end
      # connect right node to new parent
      found.right.parent = found.parent
    # no children to shift, just remove relation to parent
    else
      if found.parent.right == found
        found.parent.right = nil
      end
      if found.parent.left == found
        found.parent.left = nil
      end
    end
    # free memory for deleted node
    found = nil
  end

  # Recursive Breadth First Search
  def printf(children=nil)
    if children == nil
      children = [@root]
    end
    nextRow = []
    children.each do |child|
      puts "#{child.title}: #{child.rating}"
      nextRow.push(child.left) if child.left != nil
      nextRow.push(child.right) if child.right != nil
    end
    if nextRow.size == 0
      return nil
    else
      printf(nextRow)
    end
  end
end
