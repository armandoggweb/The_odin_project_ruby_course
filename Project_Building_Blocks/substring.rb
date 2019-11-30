dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
def substrings s, d
    s.downcase!
    sub_words = []
    res = Hash.new(0)
    d.each do |word| 
        sub_words << word if s.include?(word)
    end
    #p sub_words
    new_s = s
    count = 0
    sub_words.each do |word|
        while new_s.index(word) != nil            
            count += 1
            new_s = new_s[new_s.index(word)+1.. s.length-1]
        end
        res[word] = count
        count = 0
        new_s = s
    end
    p res
end
substrings("Howdy partner, sit down! How's it going?", dictionary)
