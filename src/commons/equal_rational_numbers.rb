=begin

972. [HARD] Equal Rational Numbers

https://leetcode.com/problems/equal-rational-numbers/

=end

class EqualRationalNumbers
	def is_rational_equal(s, t)
		x1 = s[/\((.*?)\)/, 1]
		f1 = s
		unless x1.nil?
      f1 = s.gsub("(#{x1})","")
      f1 = f1 + (x1 * 10)
		end
		
		x2 = t[/\((.*?)\)/, 1]
		f2 = t
		unless x2.nil?
      f2 = t.gsub("(#{x2})","")
      f2 = f2 + (x2 * 10)
		end
		
		return f1.to_f.round(8) == f2.to_f.round(8)
	end
end
