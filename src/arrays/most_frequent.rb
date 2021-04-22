=begin
Most Freq Occuring item in an array

example:
- [1,3,1,3,2,1] --> 1

conditions:
- always a single unique value

objective:
- with O(n)
=end

class MostFrequent
  def run(arr)
    return nil if arr.empty?
    return arr[0] if arr.size == 1

    h = {}
    max_n = max_v = 0
    arr.each do |n|
      if h.include?(n)
        h[n] += 1
      else
        h[n] = 1
      end

      if h[n] > max_n 
        max_n = h[n]
        max_v = n
      end
    end
    return max_v
  end
end