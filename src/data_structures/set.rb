class Set
  attr_reader :data
  def initialize
    @data = []
  end

  def push(n)
    return -1 if data.include?(n)
    data.push n
    n
  end
end