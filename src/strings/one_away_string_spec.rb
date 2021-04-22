
require_relative 'one_away_string'

RSpec.describe OneAwayString do
  it 'result equal to expected value' do
    ows = OneAwayString.new

    expect(ows.run('abcde','abcd')).to eq true
    expect(ows.run('abde','abcde')).to eq true
    expect(ows.run('a','a')).to eq true
    expect(ows.run('abcdef','abccef')).to eq true
    expect(ows.run('abcdef','abcde')).to eq true
    expect(ows.run('aaa','abc')).to eq false
    expect(ows.run('abcde','abc')).to eq false
    expect(ows.run('abc','abcde')).to eq false
    expect(ows.run('abc','bcc')).to eq false
    expect(ows.run('abc','abcdefgh')).to eq false
  end
end
