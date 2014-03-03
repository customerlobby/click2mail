class JobStatus
  attr_accessor :invoice,
                :job_id,
                :job_status

  def initialize(args={})
    args.each do |k,v|
      self.send("#{k}=", v)
    end
  end
end
