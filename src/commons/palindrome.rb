=begin

Palindrom checker using recursive

=end

class Palindrome
  def check?(value)
    return false if value.empty?
    return checker(value, 0)
  end

  private

  def checker(value, offset)
    if offset >= (value.size/2)
      return true
    end
    if value[offset] != value[(value.size-1)-offset]
      return false
    else
      checker(value, offset+=1)
    end
  end
end