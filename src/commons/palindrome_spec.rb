require_relative 'palindrome'

RSpec.describe Palindrome do
  describe '#check?' do
    it 'return correct result' do
      pal = Palindrome.new

      # true case
      expect(pal.check?('kodok')).to eq true
      expect(pal.check?('kaak')).to eq true
      expect(pal.check?('xo ox')).to eq true
      expect(pal.check?('dogmaiamgod')).to eq true
      expect(pal.check?('a')).to eq true

      # false case
      expect(pal.check?('abcde')).to eq false
      expect(pal.check?('abcd')).to eq false
      expect(pal.check?('')).to eq false
    end
  end
end