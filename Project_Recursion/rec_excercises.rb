#1
def mult n
    #p n
    if n == 3
        return n = 3
    end

    if n % 3 == 0 || n % 5 == 0
        return n + mult(n - 1)
    else
        return mult(n - 1)
    end
    
end
#p mult(999)

#2
require_relative 'fibonacci.rb'
def fib_list n
    res = []
    i = 0
    while i < n
        res << fibs_rec(i)
        i += 1
    end
    res
end
def even_fib n
    #p n.last
    return 2 if n.last == 2
    if n.last % 2 == 0
        #p "first: #{n}"
        return n.last + even_fib(n[0, n.length-1])
    else
        #p "second: #{n}"
        return even_fib(n[0, n.length-1])
    end
end

#p even_fib(fib_list(15))

#3
def prime n
    i = 2
    while i < n - 1
       return false if  n % i == 0
       i += 1
    end
    true
end
def largest_prime n, m = n
    #p "m:  #{m}"
    #p "n:  #{n}"
    return 1 if m == 1
    unless n % m == 0 && prime(m)
        return largest_prime(n, m - 1)
    end  
    m
end
p largest_prime(13195)