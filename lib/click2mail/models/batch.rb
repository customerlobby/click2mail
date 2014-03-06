module Click2mail
  class Batch
    attr_accessor :username,
                  :password,
                  :filename,
                  :job

    def initialize(args={})
      args.each do |k,v|
        self.send("#{k}=", v)
      end
    end

    def to_hash
      {
        :username => @username,
        :password => @password,
        :filename => @filename,
        :job      => @job.map(&:to_hash)
      }
    end

    def self.example(config = nil)
      job_example_2 = Job.example
      job_example_2.starting_page = 3
      job_example_2.ending_page = 4
      Batch.new({
        :username => [config.nil? ? "username" : config.username],
        :password => [config.nil? ? "password" : config.password],
        :filename => ['fake-file-name.xml'],
        :job      => [ Job.example, job_example_2 ]
      })
    end
  end
end
