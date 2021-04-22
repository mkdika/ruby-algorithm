=begin
Is one array a rotation of another

example:
- [1,2,3,4,5,6,7] and [4,5,6,7,1,2,3] --> true

conditions:
- no duplicates in each of arrays
- both arrays have a same size

objective:
- with O(n)
=end

class RotationAnother
  def run(arr1, arr2)
    h = {}
    for i in 0..arr1.size-1 do
      if h[arr1[i]].nil?
        h[arr1[i]] = 1
      else
        h.delete(arr1[i])
      end

      if h[arr2[i]].nil?
        h[arr2[i]] = 1
      else
        h.delete(arr2[i])
      end
    end
    h.empty?
  end
end