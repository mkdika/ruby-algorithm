require_relative 'frog_step'

RSpec.describe FrogStep do
	it 'return correct result' do
    frog = FrogStep.new

    expect(frog.count(1)).to eq 1
    expect(frog.count(2)).to eq 2
    expect(frog.count(3)).to eq 4
    expect(frog.count(4)).to eq 7
  end
end