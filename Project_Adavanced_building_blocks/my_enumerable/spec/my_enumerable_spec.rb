require '../my_enumerable.rb'
RSpec.describe '#my_each' do
    it 'returns always the array itself if some block is given' do
        expect([0, 2, "g", 6, :pp, 2].each{|d| puts d.class}).to eql([0, 2, "g", 6, :pp, 2])
    end
end
RSpec.describe '#my_select' do
    it 'returns an array with elements that match with the condition passed by block' do
        expect([0, 2, "g", 6, :pp, 2].my_select{|e| e.is_a?(Fixnum)}).to eql([0, 2, 6, 2])
    end
end
RSpec.describe '#my_all?' do
    it 'returns true if all of the elements match with the condition passed by block' do
        expect([0, 2, 3, 6, 7, 2].my_all?{|n| n.is_a?(Fixnum)}).to eql(true)
    end
    it 'returns false if all of the elements don\'t match with the condition passed by block' do
        expect([0, 2, "g", 6, :pp, 2].my_all?{|n| n.is_a?(Fixnum)}).to eql(false)
    end
end
RSpec.describe '#my_any?' do
    it 'returns true if any of the elements match with the condition passed by block' do
        expect([0, 2, "g", 6, :pp, 2].my_any?{|n| n == "g"}).to eql(true)
    end
    it 'returns false if any of the elements doesn\'t match with the condition passed by block' do
        expect([0, 2, "g", 6, :pp, 2].my_any?{|n| n == 4}).to eql(false)
    end
end
RSpec.describe '#my_none?' do
    it 'returns true if none of the elements match with the condition passed by block' do
        expect([0, 2, "g", 6, :pp, 2].my_none?{|n| n == 3}).to eql(true)
    end
    it 'returns false if some of the elements match with the condition passed by block' do
        expect([0, 2, "g", 6, :pp, 2].my_none?{|n| n == :pp}).to eql(false)
    end
end
RSpec.describe '#my_count' do
    it 'returns the number of times an element appear when matches with the condition passed by block' do
        expect([0, 2, "g", 6, :pp, 2].my_count{|n| n == 2}).to eql(2)
    end
end