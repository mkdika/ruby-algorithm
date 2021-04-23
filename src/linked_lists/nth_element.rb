class NthElement
  def run(heads, n)
    return nil if heads.nil?

    left = heads
    right = heads

    for i in (0..n-1) do
      if right == nil
        return nil
      end
      right = right.child
    end

    until right.nil?
      left = left.child
      right = right.child
    end

    return left.value
  end
end

class Node
  attr_reader :value, :child
  def initialize(value, child)
    @value = value
    @child = child
  end

  def self.create_nodes(arr)
    child = nil
    node = nil
    (arr.size-1).downto(0) do |i|
      node = Node.new(arr[i], child)
      child = node
    end
    return node
  end

  def self.print_nodes(node)
    x = []
    n = node
    begin
      x << n.value
      n = n.child
    end while n != nil
    puts x.join(' -> ')
  end
end