module Click2Mail
  class Recipient
    attr_accessor :addresses

    def to_hash
      return {:address => @addresses.map(&:to_hash)}
    end

    def self.example
      ex = Recipient.new
      ex.addresses = [ Address.example]

      return ex
    end
  end
end
