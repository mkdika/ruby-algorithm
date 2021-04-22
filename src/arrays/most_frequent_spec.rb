
require_relative 'most_frequent'

RSpec.describe MostFrequent do
  it 'result equal to expected value' do
    mf = MostFrequent.new

    expect(mf.run([])).to eq nil
    expect(mf.run([0])).to eq 0
    expect(mf.run([1,3,1,3,2,1])).to eq 1
    expect(mf.run([3,3,1,3,2,1])).to eq 3
    expect(mf.run([0, -1, 10, 10, -1, 10, -1, -1, -1, 1])).to eq -1
  end
end