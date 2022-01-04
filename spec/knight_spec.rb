# spec/knight_spec
require_relative '../lib/knight'

describe Knight do
  describe '#possible_moves' do
    subject(:knight) { described_class.new([4, 4], 'black') }
    it 'returns 8 moves when near center of board' do
      expect(knight.possible_moves).to return([[5,6],[6,5],[3,6],[6,3],[5,2],[2,3],[2,5],[3,2])
    end
    subject(:knight) { described_class.new([1,2],'black') }
    it 'returns moves only on board when near edge of board' do
      expect(knight.possible_moves).to return([[3,4],[4,3],[4,1]])
    end
  end
end 
