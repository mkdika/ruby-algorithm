=begin
scenarios:
1. can push data into set
2. can return set data 
3. only accept unique/non exists data
=end

require "rspec"
require_relative 'set'

RSpec.describe Set do
  it 'can push data into set' do
    set = Set.new

    expect(set.push(3)).to eq 3
  end

  it 'can return set data' do
    set = Set.new
    set.push 3
    set.push 1
    set.push 2

    expect(set.data).to eq [3,1,2]
  end

  describe 'only accept unique data' do
    context 'given non exists data' do
      let!(:set) { Set.new }
      it 'can be push into set and return data value' do
        expect(set.push(3)).to eq 3
        expect(set.data).to eq [3]
      end
    end
    context 'given exists data' do
      let!(:set) { Set.new }
      before do
        set.push 3
      end
      it 'data can not be pushed into set and return -1' do
        set.push 3

        expect(set.push(3)).to eq -1
        expect(set.data).to eq [3]
      end
    end
    context 'given multiple exists data' do
      it 'only have unique set of data' do
        set = Set.new
        set.push 3; set.push 4; set.push 3; set.push 2; set.push 4; set.push 3; set.push 2

        expect(set.data).to eq [3,4,2]
      end
    end
  end
end