require './lib/enumerable_methods.rb'

RSpec.describe Enumerable do
  it "loops through elements of an enumerable object" do
    res = []
    [1, 2, 3, 4].my_each { |v| res.push( v * 2)}
    expect(res).to eql([2, 4, 6, 8])
  end

  it "returns an array of elements fulfilling the condition in a block" do
    res = [1, 2, 3, 4].my_select { |v| v.odd?}
    expect(res).to eql([1, 3])
  end

  it "returns an array of returned elements from a block" do
    res = [1, 2, 3, 4].my_map { |v| v.odd?}
    expect(res).to eql([true, false, true, false])
  end
end