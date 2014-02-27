class Address
  attr_accessor :name,
                :organization,
                :address1,
                :address2,
                :address3,
                :city,
                :state,
                :postal_code,
                :country

  def initialize(args={})
    args.each do |k,v|
      self.send("#{k}=", v)
    end
  end

  def to_hash
    {

      "name"         => @name,
      "organization" => @organization,
      "address1"     => @address1,
      "address2"     => @address2,
      "address3"     => @address3,
      "city"         => @city,
      "state"        => @state,
      "postalCode"   => @postal_code,
      "country"      => @country,
    }
  end

  def self.example
    return Address.new({
      name: '',
      organization: '',
      address1: '',
      address2: '',
      address3: '',
      city: '',
      state: '',
      postal_code: '',
      country: '',
    })
  end
end
