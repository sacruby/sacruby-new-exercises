require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/rpn_calculator'

describe RPNCalculator do

  attr_accessor :calculator

  before do
    @calculator = RPNCalculator.new
  end

  it "adds two numbers" do
    calculator.push(2)
    calculator.push(3)
    calculator.push(:+)
    calculator.value.must_equal 5
  end

  it "adds three numbers" do
    calculator.push(2)
    calculator.push(3)
    calculator.push(4)
    calculator.push(:+)
    calculator.value.must_equal 7
    calculator.push(:+)
    calculator.value.must_equal 9
  end

  it "subtracts the second number from the first number" do
    calculator.push(2)
    calculator.push(3)
    calculator.push(:-)
    calculator.value.must_equal -1
  end

  it "adds and subtracts" do
    calculator.push(2)
    calculator.push(3)
    calculator.push(4)
    calculator.push(:-)
    calculator.value.must_equal -1
    calculator.push(:+)
    calculator.value.must_equal 1
  end

  it "multiplies and divides" do
    calculator.push(2)
    calculator.push(3)
    calculator.push(4)
    calculator.push(:/)
    calculator.value.must_equal (3.0 / 4.0)
    calculator.push(:*)
    calculator.value.must_equal 2.0 * (3.0 / 4.0)
  end

  it "resolves operator precedence unambiguously" do
    # 1 2 + 3 * => (1 + 2) * 3
    calculator.push(1)
    calculator.push(2)
    calculator.push(:+)
    calculator.push(3)
    calculator.push(:*)
    calculator.value.must_equal (1 + 2) * 3

    @calculator = RPNCalculator.new
    # 1 2 3 * + => 1 + (2 * 3)
    calculator.push(1)
    calculator.push(2)
    calculator.push(3)
    calculator.push(:*)
    calculator.push(:+)
    calculator.value.must_equal 1 + (2 * 3)
  end

  it "evaluates a string" do
    calculator.evaluate("1 2 3 * +").must_equal ((2 * 3) + 1)
    calculator.evaluate("4 5 -").must_equal (4 - 5)
    calculator.evaluate("2 3 /").must_equal (2.0 / 3.0)
    calculator.evaluate("1 2 3 * + 4 5 - /").must_equal (1.0 + (2 * 3)) / (4 - 5)
  end

end
