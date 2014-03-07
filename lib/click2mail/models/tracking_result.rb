module Click2Mail
  class TrackingResult
    attr_accessor :barcode,
                  :recipient_address,
                  :status,
                  :stat_date_time,
                  :city,
                  :state

    def initialize(hash_args)
      parse(hash_args)
    end

    def parse(hash_args)
      @barcode            = hash_args["Barcode"].first
      @recipient_address  = hash_args["recipientAddress"].first
      @status             = hash_args["status"].first
      @stat_date_time     = Date.parse(hash_args["statDateTime"].first)
      @city               = hash_args["city"].first
      @state              = hash_args["state"].first
    end
  end
end
