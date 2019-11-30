class LinkedList
    def initialize
       @head
    end
    def append(value)
        unless @head.nil?
            temp = @head
            until temp.next.nil?
                temp = temp.next
            end
            temp.next = Node.new(value)
        else
            @head = Node.new(value)
        end
    end
    def prepend(value)
        unless @head.nil?
            temp = Node.new(value)
            temp.next = @head
            @head = temp
        else
            @head = Node.new(value)
        end
    end
    def size
        unless @head.nil?
            n_nodes = 1
            temp = @head
            until temp.next.nil?
                temp = temp.next
                n_nodes +=1
            end
            return n_nodes
        else
            return "There are not any nodes"
        end
    end
    def head
        @head
    end
    def tail
        temp = @head
        until temp.next.nil?
            temp = temp.next
        end
        temp
    end
    def at(index)
        temp = @head
        i = 0
        until i == index
            temp = temp.next
            i += 1
        end
        temp
    end
    def pop
        temp = @head
        until temp.next == self.tail
            temp = temp.next
        end
        temp.next = nil
    end
    def contains?(value)
        temp = @head
        until temp.nil?
            return true if temp.value == value
            temp = temp.next
        end
        false
    end
    def find(data)
        temp = @head
        i = 0
        until temp.nil?
            return i if temp.value == data
            i += 1
            temp = temp.next
        end
        nil
    end
    def to_s
        res =""
        temp = @head
        until temp.nil?
            res += "( #{temp.value} ) -> "
            temp = temp.next
        end
        res += "nil"
    end
    def insert_at(index, value)
        if index == 0
            self.prepend(value)
        else
            temp = @head
            i = 0
            until i == index - 1
                temp = temp.next
                i += 1
            end
            temp_2 = Node.new(value)
            temp_2.next = temp.next
            temp.next = temp_2
        end
    end
    def remove_at(index)
        temp = @head
        i = 0
        until i == index - 1
            temp = temp.next
            i += 1
        end
        temp.next = temp.next.next
    end
end
class Node
    attr_accessor :value, :next
    def initialize (value = nil)
        @value = value
        @next = nil 
    end
end
lista = LinkedList.new
lista.prepend("cuarto")
lista.append("primero")
lista.prepend("segundo")
lista.append("tercero")
p lista.to_s
#p lista.size
#p lista.tail
#p lista.at(0)
#lista.pop
#p lista.contains?("cuarto")
#p lista.find("tercero")
lista.insert_at(3, "quinto")
p lista.to_s
lista.remove_at(1)
p lista.to_s

