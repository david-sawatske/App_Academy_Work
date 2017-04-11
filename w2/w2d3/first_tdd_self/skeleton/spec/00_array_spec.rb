require 'rspec'
require '00_array'

describe 'my_uniq' do
  it 'returns an array of uniq elements' do
    expect(my_uniq([1,3,1,23,4])).to eq([1,3,23,4])
  end
end

describe '#two_sum' do
  it 'returns index pairs that sum to zero' do
    expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
  end
end

describe "transpose" do
  it "transposes a matrix" do
    matrix = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]

    expect(my_transpose(matrix)).to eq([
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9]
    ])
  end
end
