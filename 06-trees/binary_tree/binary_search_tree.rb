require_relative 'node'

class BinarySearchTree

  def initialize(root)
    @root = root
  end

  def insert(root, node)
    currNode = root
    if node.rating > currNode.rating
      if currNode.right == nil
        currNode.right = node
        currNode.right.parent = currNode
      else
        insert(currNode.right, node)
      end
    elsif node.rating < currNode.rating
      if currNode.left == nil
        currNode.left = node
        currNode.left.parent = currNode
      else
        insert(currNode.left, node)
      end
    else
      return "error, no duplicate ratings"
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
    # find highest child of left child to take deleted node's place
    if found.left != nil
      temp = found.left
      until (temp.right != nil || temp.left == nil) do
        temp = temp.left
      end
      # found a right node, now find the highest value right child
      if temp.right != nil
        until (temp.right == nil) do
          temp = temp.right
        end
      end
      # connect deleted node's parent to new child
      if found != @root
        if found.parent.right == found
          found.parent.right = temp
        else
          found.parent.left = temp
        end
      end
      # take care of temp's old relationships
      if temp.parent.left == temp
        temp.parent.left = nil
      else
        temp.parent.right = nil
      end
      if temp.left != nil
        temp.left.parent = temp.parent
        temp.parent.right = temp.left
      end
      # connect deleted node's child(ren) to new parent
      if found.left != temp
        found.left.parent = temp if found.left != nil
        temp.left = found.left
      end
      if found.right != nil
        found.right.parent = temp
        temp.right = found.right
      end
      # connect replacement node to new parent
      if found == @root
        temp.parent = nil
        @root = temp
      else
        temp.parent = found.parent
      end
    # move right child to take deleted node's place if no left child
    elsif found.right != nil
      temp = found.right
      # find lowest replacement node to take deleted node's place
      until (temp.left != nil || temp.right == nil) do
        temp = temp.right
      end
      # found a left node, now find the lowest value left child
      if temp.left != nil
        until (temp.left == nil) do
          temp = temp.left
        end
      end
      # connect deleted node's parent to new child
      if found != @root
        if found.parent.right == found
          found.parent.right = temp
        else
          found.parent.left = temp
        end
      end
      # take care of temp's old relationships
      if temp.parent.left == temp
        temp.parent.left = nil
      else
        temp.parent.right = nil
      end
      if temp.right != nil
        temp.right.parent = temp.parent
        temp.parent.left = temp.right
      end
      # connect deleted node's child(ren) to new parent
      if found.right != temp
        found.right.parent = temp if found.right != nil
        temp.right = found.right
      end
      # connect replacement node to new parent
      if found == @root
        temp.parent = nil
        @root = temp
      else
        temp.parent = found.parent
      end
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
      # puts "L: #{child.left.title}" if child.left.title != nil
      # puts "R: #{child.right.title}" if child.right.title != nil
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
