require_relative 'my_enumerable.rb'
[1,4,2].my_each{|r| r+2}
[1,4,2].my_each_with_index{|r, t| r + t}
[1,4,2].my_select{|r| r%2 == 0}
[1,4,2].my_all?{|r| r > 1}
[1,4,2].my_any?{|r| r > 6}
[1,4,2].my_none?{|r| r == 1}
[1,4,2].my_count{|r| r%4 == 0}
p [1,4,2].my_map{|r| r * 3}
[1,4,2].my_inject(0){|r, t| r + t}

def multiply_els(n)
    n.my_inject(1){|m, t| m * t}
end
multiply_els([2, 4, 5])


p [1,4,2].my_map(&proc{|r| r * 3})
#p [1,4,2].my_map(&proc{|r| r * 4}){|r| r * 3}