#lib/calculator.rb

class Calculator
  def add(*n)
    res = 0
    n.each{|number| res += number}
    res
  end
  def multiply(a,b)
    a * b
  end
  def subtract(a,b)
    a - b
  end
  def divide(a,b)
    a / b
  end

end

