require_relative 'node'

class Heap
  attr_reader :root

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
        node.parent = child
        placed = node
      # if not emptry, add right child to search queue
      elsif child.right == nil
        child.right = node
        node.parent = child
        placed = node
      else
        nextRow.push(child.left)
        nextRow.push(child.right)
      end
      if placed
        break
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
      if node.rating < node.parent.rating
        # node's grandparent
        g = node.parent.parent if node.parent.parent != nil
        # node's parent
        d = node.parent
        # node's children
        l = node.left if node.left != nil
        r = node.right if node.right != nil

        # temp var o if node's parent has another child
        if d.left == node
          o = node.parent.right if d.right != nil
        else
          o = node.parent.left if d.left != nil
        end
        if o != nil
          # connect node to node's parent's other child
          if d.left == node
            node.right = o
          else
            node.left = o
          end
          # connect node's parent's other child to node
          o.parent = node
        end
        # reconnect node to node's parent
        if d.left == node
          node.left = d
        else
          node.right = d
        end
        # reconnect node's parent to node
        d.parent = node
        # connect node's children to new parent
        l.parent = d if l != nil
        r.parent = d if r != nil
        # connect node's parent to new children
        d.left = l
        d.right = r
        # connect node's grandparent to node
        if g != nil && g.left == d
          g.left = node
        end
        if g != nil && g.right == d
          g.right = node
        end
        # connect node to node's grandparent
        if g != nil
          node.parent = g
        else
          node.parent = nil
          @root = node
        end

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
    replacement = grab_last()
    if replacement != found
      # remove relationship to old parent for replacement node
      if replacement.parent.right == replacement
        replacement.parent.right = nil
      end
      if replacement.parent.left == replacement
        replacement.parent.left = nil
      end
      # connect replacement node to found's parent
      if found.parent != nil
        replacement.parent = found.parent
        # connect found's parent to replacement
        if found.parent.left == found
          found.parent.left = replacement
        else
          found.parent.right = replacement
        end
      else
        replacement.parent = nil
        @root = replacement
      end
      replacement.left = found.left if found.left != nil
      replacement.right = found.right if found.right != nil
      found = nil
      order(replacement)
      lower(replacement)
    else
      if found.parent.left == found
        found.parent.left = nil
      else
        found.parent.right = nil
      end
      found = nil
    end
  end

  def lower(node)
    if node.left != nil && node.rating > node.left.rating && node.left.rating < node.right.rating
      swap = node.left
    elsif node.right != nil && node.rating > node.right.rating && node.right.rating < node.left.rating
      swap = node.right
    else
      return
    end
    sL = swap.left if swap.left != nil
    sR = swap.right if swap.right != nil
    if swap == node.left
      o = node.right if node.right != nil
    else
      o = node.left if node.left != nil
    end
    # connect swap to node's parent
    if node.parent != nil
      swap.parent = node.parent
      # connect node's parent to swap
      if node.parent.left == node
        node.parent.left = swap
      else
        node.parent.right = swap
      end
    else
      swap.parent = nil
      @root = swap
    end
    # connect node and node's other child to swap
    node.parent = swap
    o.parent = swap if o != nil
    # connect swap to node and node's other child
    if node.left == swap
      swap.left = node
      swap.right = o
    else
      swap.right = node
      swap.left = o
    end
    # connect swaps old children to node
    node.left = sL
    node.right = sR
    sL.parent = node if sL != nil
    sR.parent = node if sR != nil

    lower(node)
  end


  def grab_last(children=nil)
    if children == nil
      children = [@root]
    end
    nextRow = []
    children.each do |child|
      nextRow.push(child.left) if child.left != nil
      nextRow.push(child.right) if child.right != nil
    end
    if nextRow.size == 0
      return children[-1]
    else
      grab_last(nextRow)
    end
  end

  # Recursive Breadth First Search
  def printf(children=nil)
    if children == nil
      if @root
        children = [@root]
      else
        return nil
      end
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
