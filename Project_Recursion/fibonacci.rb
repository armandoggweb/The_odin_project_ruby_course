def fibs n
    seq = [0, 1]
    1.upto(n - 1) do |index|
        seq << seq[index - 1] + seq[index]
    end
    seq
end

def fibs_rec n

    n < 2 ? (return n) : fibs_rec(n - 1) + fibs_rec(n-2)
    
end
#fibs(8)