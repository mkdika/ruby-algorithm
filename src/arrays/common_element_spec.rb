
require_relative 'common_element'

RSpec.describe CommonElement do
  it 'result equal to expected value' do
    ce = CommonElement.new

    expect(ce.run([1, 3, 4, 6, 7, 9],[1, 2, 4, 5, 9, 10])).to eq [1,4,9]
    expect(ce.run([1, 3, 4, 6, 7, 9,11],[1, 2, 4, 5, 9, 10,11])).to eq [1,4,9,11]
    expect(ce.run([1, 2, 9, 10, 11, 12], [0, 1, 2, 3, 4, 5, 8, 9, 10, 12, 14, 15])).to eq [1, 2, 9, 10, 12] 
    expect(ce.run([0, 1, 2, 3, 4, 5], [6, 7, 8, 9, 10, 11])).to eq []
  end
end
