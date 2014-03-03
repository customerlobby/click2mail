class ReturnAddress
  attr_accessor :name,
                :organization,
                :address1,
                :address2,
                :city,
                :state,
                :postal_code

  def initialize(args={})
    args.each do |k,v|
      self.send("#{k}=", v)
    end
  end

  def to_hash
    {
      "name"         => [@name],
      "organization" => [@organization],
      "address1"     => [@address1],
      "address2"     => [@address2],
      "city"         => [@city],
      "state"        => [@state],
      "postalCode"   => [@postal_code],
    }
  end

  def self.example
    return ReturnAddress.new({
      name:         'Name',
      organization: 'Organiztion',
      address1:     'address1',
      address2:     'address2',
      city:         'city',
      state:        'state',
      postal_code:  'postal code',
    })
  end
end
