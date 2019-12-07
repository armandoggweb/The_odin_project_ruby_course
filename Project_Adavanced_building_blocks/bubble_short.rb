def bubble_sort(a)
    temp = 0
    sorted = false
    while sorted == false
        sorted = true
        a[0..a.length-2].each_index do |n|         
            if a[n] > a[n+1]
                temp = a[n]
                a[n] = a[n+1]
                a[n+1] = temp
                sorted = false
            end
        end
    end
    p a
end
bubble_sort([4,3,78,2,0,2])