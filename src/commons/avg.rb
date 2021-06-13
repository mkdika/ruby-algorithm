arr = [11] #[1,3,5,7,11]
l = 8

nums = arr.length
counter = 0
r = 0
avg = 0

arr.each do |a|	
	if l > 0
    n = (a.to_f / nums.to_f).ceil
    counter += 1
    avg = avg + n
    r = avg / counter
    l -= n
	end
end

puts counter