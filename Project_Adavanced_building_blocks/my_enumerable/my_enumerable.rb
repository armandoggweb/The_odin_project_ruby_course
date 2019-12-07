module Enumerable
    def my_each
        for i in self do
            yield i
        end
        self
    end
    def my_each_with_index
        index = 0
        for element in self do
            yield(element, index)
            index += 1
        end
    end
    def my_select 
        res = []
        self.my_each do |element|
           res << element if yield element
        end
        res
    end
    def my_all?
        self.my_each do |element|
            return false unless yield element 
        end
        true
    end
    def my_any? 
        self.my_each do |element|
            return true if yield element 
        end
        false
    end
    def my_none?
        self.my_each do |element|
            return false if yield element 
        end
        true
    end
    def my_count 
        res = 0
        self.my_each do |element|
           res += 1 if yield element
        end
        res
    end
    def my_map &p
        res = []
        self.my_each do |element|
            unless p.nil?()
                temp = p.call(element)
            else
                temp = (yield element)
            end
            res << temp
        end
        res
    end

    def my_inject(i = self[0])
        res = i
        self.my_each do |element|
           res = yield(res, element)
        end
        res
    end
end