require_relative 'mine_sweeper'

RSpec.describe MineSweeper do
  it 'result equal to expected value' do
    mine_sweeper = MineSweeper.new(10, 10)
    random_bombs = mine_sweeper.random_bombs(10)
    mine_sweeper.generate_and_print(random_bombs)
  end 
end