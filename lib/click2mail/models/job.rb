class Job
  attr_accessor :starting_page,
                :ending_page,
                :print_production_options,
                :return_address,
                :recipients

  def initialize(args={})
    args.each do |k,v|
      self.send("#{k}=", v)
    end
  end

  def to_hash
    return {
      "startingPage"           => [@starting_page],
      "endingPage"             => [@ending_page],
      "printProductionOptions" => [@print_production_options.to_hash],
      "returnAddress"          => [@return_address.to_hash],
      "recipients"             => [@recipients.to_hash],
    }
  end

  def self.example
    Job.new({
      :starting_page => '1',
      :ending_page => '2',
      :print_production_options => PrintProductionOptions.example,
      :return_address => ReturnAddress.example,
      :recipients => Recipient.example,
    })
  end
end
