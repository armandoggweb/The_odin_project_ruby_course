def bubble_sort_by a
    temp = 0
    sorted = false

    while sorted == false
        sorted = true

        a[0..a.length-2].each_index do |n|         
            if yield(a[n], a[n+1]) > 0
                temp = a[n]
                a[n] = a[n+1]
                a[n+1] = temp
                sorted = false
            end
        end
    end

    p a
end

bubble_sort_by(["hi","hello","hey"]) { |left,right| left.length - right.length }
