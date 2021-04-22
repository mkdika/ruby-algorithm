=begin
Common elements in two sorted arrays

write a function that returns the common elements (as an array) between
2 sorted arrays of integer (ascending ordered).

example:
- [1,3,4,6,7,9] and [1,2,4,5,9,10] --> [1,4,9]

objective:
- with O(max[n,m])
=end

class CommonElement
  def run(arr1, arr2)
    result = []
    p1 = p2 = 0

    while p1 < arr1.size && p2 < arr2.size
      if arr1[p1] == arr2[p2]
        result << arr1[p1]
        p1 += 1; p2 += 1
      elsif arr1[p1] > arr2[p2]
        p2 += 1;
      else
        p1 += 1;
      end
    end
    result
  end
end