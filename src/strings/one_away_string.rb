=begin
One away string

there are one away from each other if a single operation:
- changing a char
- deleting a char
- add a char
will change one of the strings to the other

example:
- "abcde" and "abcd" (deleting a char) --> true
- "abc" and "bcc" --> false

objective:
- with O(n)
=end

class OneAwayString
  def run(str1, str2)
    return true if str1 == str2
    return false if (str1.size - str2.size).abs >= 2

    s1 = str1.clone; s2 = str2.clone
    if str1.size < str2.size
      # add char
      for i in 0..s1.size-1 do
        if s1[i] != s2[i]
          x = s1.clone
          if x.insert(i, s2[i]) == s2
            return true
          else
            break
          end
        end
      end
      # end
    elsif str2.size < str1.size
      # remove char
      for i in 0..s1.size-1 do
        if i == s2.size || s1[i] != s2[i]
          x = s1.clone
          x.slice!(i)
          if x == s2
            return true
          else
            break
          end
        end
      end
      # end
    else
      # change char
      for i in 0..s1.size-1 do
        if s1[i] != s2[i]
          s1[i] = s2[i]
          if s1 == s2
            return true
          else
            break
          end
        end        
      end
      # end
    end

    return false
  end
end