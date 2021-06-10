=begin

A frog is running up a staircase with n steps and can hop either 1 step, 2 steps, or 3 steps at a time. 
Implement a method to count how many possible ways the frog can run up the stairs.

=end

class FrogStep
	def count(n)
    if (n == 1 || n == 0)
      return 1
    elsif (n == 2)
      return 2
    else
      return count(n-1) + count(n-2) + count(n-3)
    end
	end
end