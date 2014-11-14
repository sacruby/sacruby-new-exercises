class Iterator

  attr_reader :array

  def initialize(array)
    raise "Iterator only iterates over an array" unless array.is_a? Array
    raise "Array elements must be of the same class" if array.map(&:class).uniq.count > 1
    @array =  array
  end

end
