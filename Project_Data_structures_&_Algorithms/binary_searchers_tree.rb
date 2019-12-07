class Node
    attr_accessor :value, :left_child, :right_child
=begin
    include Comparable
    def <=>(other)
        self == other
    end
=end
    def initialize(value = nil, left = nil, right = nil)
        @value = value
        @left_child = left
        @right_child = right
    end
end

class Tree
    def initialize(arr)
        @root = build_tree(arr)
    end
    def build_tree(arr)
        arr.uniq!
        temp = arr.sort
        temp = temp[temp.length/2]
        arr.delete(temp)
        arr.unshift(temp)
        first = Node.new(arr.first)
        arr[1, arr.length].each do |n|
            self.insert(n, first)
        end
        first
    end
    def insert(data, root = @root)
        temp = root
        added = false
        until added
            if data > temp.value 
                if temp.right_child.nil?
                    temp.right_child = Node.new(data)
                    added = true
                end
                temp = temp.right_child
            else 
                if  temp.left_child.nil?
                    temp.left_child = Node.new(data)
                    added = true
                end
                temp = temp.left_child
            end
        end
    end
    def insert_node(node, root)
        temp = root
        added = false
        until added
            if node.value > temp.value 
                if temp.right_child.nil?
                    temp.right_child = node
                    added = true
                end
                temp = temp.right_child
            else 
                if  temp.left_child.nil?
                    temp.left_child = node
                    added = true
                end
                temp = temp.left_child
            end
        end
    end
    def delete (data)
        current = @root
        previous = current
        deleted = false
        until deleted
            if current.value == data
                unless current.left_child.nil?
                    if previous.value > current.left_child.value
                        prevoius.left_child = current.left_child
                    else
                        previous.right_child = current.left_child
                    end
                    temp = current.left_child
                else
                    temp = previous
                end
                insert_node(current.right_child, temp) unless current.right_child.nil?
                deleted = true
            elsif current.value < data
                previous = current
                current = current.right_child
            else
                previous = current
                current = current.left_child
            end
        end
    end
    def find(data)
        current = @root
        found = false
        until found
            if current.value == data
                found = true
            else 
                current.value > data ? current = current.left_child : current = current.right_child
            end
        end
        current
    end
    def level_order
        values = [] 
        queue = [@root]
        until queue.empty?
            block_given? ? (yield queue.first) : values << queue.first.value
            queue << queue.first.left_child unless queue.first.left_child.nil?
            queue << queue.first.right_child unless queue.first.right_child.nil?
            queue.shift
        end
        values unless block_given?
    end

    def level_order_rec(node = @root) #incomplete??
        p node.value
        yield node if block_given?
        return node if node.left_child.nil? && node.right_child.nil?
        level_order_rec(node.left_child) unless node.left_child.nil?
        level_order_rec(node.right_child) unless node.right_child.nil?
    end

    def show(arr)
        res = []
        arr.each do |e| 
            e.nil? ? o = nil : o = e.value
            res.push(o)
        end
        res
    end
    #Actualizar como preorder
    def inorder
        values = []
        values << preorder(@root.left_child) unless @root.left_child.nil?
        values << @root.value
        values << preorder(@root.right_child) unless @root.right_child.nil?
        values.flatten
    end

    def preorder(first_node = @root)
        values = [first_node.value]
        stack = [first_node]
        return values if first_node.left_child.nil? && first_node.right_child.nil?
        loop do
            #p show(stack)
            unless stack.last.left_child.nil?
                stack << stack.last.left_child
                values << stack.last.value
            else
                unless stack.last.right_child.nil?
                    stack << stack.last.right_child
                    values << stack.last.value
                else
                    temp = stack.pop
                    if stack.last.right_child != temp && !stack.last.right_child.nil?
                        stack << stack.last.right_child
                        values << stack.last.value unless stack.last.nil?
                    else
                        temp = stack.pop
                        while !stack.last.nil? && (temp == stack.last.right_child || stack.last.right_child.nil?)
                            temp = stack.pop
                        end
                        break if stack.last.nil?
                        unless stack.last.right_child.nil?
                            stack << stack.last.right_child
                            values << stack.last.value
                        end
                    end
                end
            end
        end
        values
    end
    #Actualizar como preorder
    def postorder
        values = []
        values << preorder(@root.right_child) unless @root.right_child.nil?
        values << @root.value
        values << preorder(@root.left_child) unless @root.left_child.nil?
        values.flatten
    end
    def depth(node, deepest_level = false)
        return 1 if @root.left_child.nil? && @root.right_child.nil?
        level = 1
        max = 0
        stack = [@root]
        loop do
            #p show(stack)
            break if stack.last == node
            unless stack.last.left_child.nil?
                stack << stack.last.left_child
                level += 1
            else
                unless stack.last.right_child.nil?
                    stack << stack.last.right_child
                    level += 1
                else
                    temp = stack.pop
                    level -= 1
                    if stack.last.right_child != temp && !stack.last.right_child.nil?
                        stack << stack.last.right_child
                        level += 1
                    else
                        temp = stack.pop
                        level -= 1
                        while !stack.last.nil? && (temp == stack.last.right_child || stack.last.right_child.nil?)
                            temp = stack.pop
                            level -= 1
                        end
                        break if stack.last.nil?
                        unless stack.last.right_child.nil?
                            stack << stack.last.right_child
                            level += 1
                        end
                    end
                end
            end
            max = level if level > max
        end
        return max if deepest_level
        level
    end
    
    def balanced?
        @root.left_child.nil? ? left_branch_height = 0 : left_branch_height = Tree.new(self.preorder(@root.left_child)).depth(nil, true)
        p left_branch_height
        @root.right_child.nil? ? right_branch_height = 0 : right_branch_height = Tree.new(self.preorder(@root.right_child)).depth(nil, true)
        p right_branch_height
        (left_branch_height - right_branch_height).abs > 1 ? false : true
    end
    def rebalance!
        @root = self.build_tree(self.level_order)
    end

end

tree = Tree.new(Array.new(15){rand(100)})

p "level order: #{tree.level_order}"
p "balanced?:   #{tree.balanced?}"
p "preorder:    #{tree.preorder}"
p "inorder:     #{tree.inorder}"
p "postorder:   #{tree.postorder}"


100.times{ tree.insert(rand(100)) }

p "balanced?2:   #{tree.balanced?}"
tree.rebalance!

p "balanced?3:   #{tree.balanced?}"

p "level order: #{tree.level_order}"
p "preorder:    #{tree.preorder}"
p "inorder:     #{tree.inorder}"
p "postorder:   #{tree.postorder}"
