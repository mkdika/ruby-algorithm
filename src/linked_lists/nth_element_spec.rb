require_relative 'nth_element'

RSpec.describe NthElement do
  it 'result equal to expected value' do
    nth = NthElement.new

    arr1 = [7,6,5,4,3,2,1]
    nodes1 = Node.create_nodes(arr1)

    arr2 = [1,2,3,4]
    nodes2 = Node.create_nodes(arr2)
    Node.print_nodes(nodes2)

    expect(nth.run(nodes1, 1)).to eq 1
    expect(nth.run(nodes1, 5)).to eq 5
    expect(nth.run(nodes2, 2)).to eq 3
    expect(nth.run(nodes2, 4)).to eq 1
    expect(nth.run(nodes2, 5)).to eq nil
    expect(nth.run(nil, 1)).to eq nil

  end
end