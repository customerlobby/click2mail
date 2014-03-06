module Click2mail
  class PrintProductionOptions
    attr_accessor :document_class,
                  :layout,
                  :production_time,
                  :envelope,
                  :color,
                  :paper_type,
                  :print_option,
                  :mail_class

    def initialize(args={})
      args.each do |k,v|
        self.send("#{k}=", v)
      end
    end

    def to_hash
      return {
        "documentClass"  => [@document_class],
        "layout"         => [@layout],
        "productionTime" => [@production_time],
        "envelope"       => [@envelope],
        "color"          => [@color],
        "paperType"      => [@paper_type],
        "printOption"    => [@print_option],
        "mailClass"      => [@mail_class],
      }
    end

    def self.example
      return PrintProductionOptions.new({
        document_class:   "Postcard 4.25 x 6",
        layout:           "Picture Postcard",
        production_time:  "Next Day",
        envelope:         "",
        color:            "Full Color",
        paper_type:       "White Matte with Gloss UV Finish",
        print_option:     "Printing both sides",
        mail_class:       "First Class",
      })
    end
  end
end
