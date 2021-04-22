require_relative 'rotation_another'

RSpec.describe RotationAnother do
  it 'result equal to expected value' do
    ra = RotationAnother.new

    arr1 = [1,2,3,4,5,6,7]
    arr2 = [4,5,6,7,1,2,3]
    expect(ra.run(arr1, arr2)).to eq true

    arr2a = [4, 5, 6, 8, 1, 2, 3]
    expect(ra.run(arr1, arr2a)).to eq false

    arr2b = [4, 5, 6, 7, 1, 2, 3]
    expect(ra.run(arr1, arr2b)).to eq true

    arr2c = [4, 5, 6, 9, 1, 2, 3]
    expect(ra.run(arr1, arr2c)).to eq false

    arr2d = [4, 6, 5, 7, 1, 2, 3]
    expect(ra.run(arr1, arr2d)).to eq true

    arr2e = [4, 5, 6, 7, 0, 2, 3]
    expect(ra.run(arr1, arr2e)).to eq false

    arr2f = [1, 2, 3, 4, 5, 6, 7]
    expect(ra.run(arr1, arr2f)).to eq true

    arr2g = [7, 1, 2, 3, 4, 5, 6]
    expect(ra.run(arr1, arr2g)).to eq true
  end
end
