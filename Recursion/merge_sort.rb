def merge_sort n
    puts "Splitting: #{n}"
    m = n.length/2
    return n if n.length <= 1
    left = []
    right = []
    n.each_index  {|i| i < m ? (left << n[i]) : (right << n[i])}
    left = merge_sort(left)
    right = merge_sort(right)
    p "left = #{left}"
    p "right = #{right}"
    i = 0
    j = 0
    k = 0
    unless left.nil? || right.nil?
        while i < left.length && j < right.length
            if left[i] <= right[j]
                n[k] = left[i]
                i += 1
            else
                n[k] = right[j]
                j += 1
            end
            k += 1
        end
    end
    while !left.nil? && i < left.length 
        n[k] = left[i]
        i += 1
        k += 1
    end
    while !right.nil? && j < right.length
        n[k] = right[j]
        j += 1
        k += 1
    end
    puts "Sorted: #{n}"
    n
end

p merge_sort([5, 0, 4, 3, 2])
