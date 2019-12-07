#spec/calculator_spec.rb
require '../lib/calculator.rb'
RSpec.describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7)
    end
    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end
  describe '#multiply' do
    it "returns the multiplication of two numbers" do
      calculator = Calculator.new
      expect(calculator.multiply(5, 2)).to eql(10)
    end
  end
  describe '#subtract' do
    it "returns the subtraction of two numbers" do
      calculator = Calculator.new
      expect(calculator.subtract(5, 2)).to eql(3)
    end
  end
  describe '#divide' do
    it "returns the divition of two numbers" do
      calculator = Calculator.new
      expect(calculator.divide(6, 2)).to eql(3)
    end
  end
end

