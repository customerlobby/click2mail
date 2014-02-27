class Recipient
  attr_accessor :addresses

  def to_hash
    return @addresses.map(&:to_hash)
  end

  def self.example
    ex = Recipient.new
    ex.addresses = [ Address.example, Address.example, Address.example]

    return ex
  end
end
