# spec/knight_spec
require_relative '../lib/knight'

describe Knight do
  describe '#possible_moves' do
    context 'when position near center of board' do
      subject(:knight) { described_class.new({}, [4, 4], 'black') }
      it 'returns 8 moves' do
        moves = knight.possible_moves
        expect(moves).to eq([[5,6],[6,5],[3,6],[6,3],[5,2],[2,3],[2,5],[3,2]])
      end
    end
    context 'when position near edge of board' do
      subject(:knight) { described_class.new({}, [1,2],'black') }
      it 'returns moves only on board' do
        moves = knight.possible_moves
        expect(moves).to include([2,4],[3,3],[3,1])
      end
    end
  end
end 
