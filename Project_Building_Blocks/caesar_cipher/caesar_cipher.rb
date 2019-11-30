def caesar_cipher s, n
    s.capitalize!
    p s
    res = ""
    s.each_char do |c|
        unless '! '.index(c)
            if c == c.upcase && c.ord + n > 90 
                c = ((c.ord + n)-90)+64
                res += c.chr
            else
                res += (c.ord + n).chr
            end
        else
            res += c
        end
    end
    res
end
#puts caesar_cipher("what a string!",5)
