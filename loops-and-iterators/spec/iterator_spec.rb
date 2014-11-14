require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/iterator'

describe Iterator do
  describe '#initialize' do
    it "accepts an array as the single argument" do
      Iterator.new([]).must_be_instance_of(Iterator)
    end

    it "can't be initialized without an argument" do
      proc { Iterator.new() }.must_raise(ArgumentError)
    end

    it "can't be initialized with anything other than an array" do
      proc { Iterator.new(123) }.must_raise(RuntimeError)
    end
  end

  describe '#count' do
    it "returns the count of the element in the array" do
      Iterator.new([1,2,2,2,4]).count(2).must_equal(3)
    end
  end

  describe '#remove_duplicates' do
    it "returns the unique elements of the array" do
      Iterator.new([1,2,2,3,4,4]).remove_duplicates.must_equal([1,2,3,4])
    end
  end

  describe '#add_all' do
    it "returns the unique elements of the array" do
      Iterator.new([1,2,2,3,4,4]).uniques_only.must_equal(16)
    end
  end
end
