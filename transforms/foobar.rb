class Foobar
    def self.blerp(word)
        return word.upcase
    end

    def self.baz(word)
        word.delete('bar')
        return word
    end
end