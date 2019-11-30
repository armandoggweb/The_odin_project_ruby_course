require '../caesar_cipher.rb'
RSpec.describe '#caesar_cipher' do
    it "returns correctly one simple word" do
        expect(caesar_cipher("string", 5)).to eql("Xywnsl")
    end
    it "returns correctly two or more words" do
        expect(caesar_cipher("What a string", 5)).to eql("Bmfy f xywnsl")
    end
    it "returns the word without modify the punctuation" do
        expect(caesar_cipher("What a string!", 5)).to eql("Bmfy f xywnsl!")
    end
    it "returns the first word of the sentence capitalized" do
        expect(caesar_cipher("what a string", 5)).to eql("Bmfy f xywnsl")
    end
end
