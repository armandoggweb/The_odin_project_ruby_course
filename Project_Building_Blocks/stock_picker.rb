def stock_picker a

    buy_day = 0
    sell_day = 0
    diference = 0
    
    a.each do |value|
        a[a.index(value)..a.length-1].each do |value_2|
            if value_2 - value > diference && value < value_2
                diference = value_2 - value
                buy_day = a.index(value)
                sell_day = a.index(value_2)
            end
        end
    end

    p [buy_day, sell_day]

end
stock_picker([17,3,6,9,15,8,6,1,10])
