module Click2Mail
  class BatchXMLBuilder
    def initialize(configuration, job, filename)
      @configuration = configuration
      @job = job
      @filename = filename
    end

    def to_xml
      xml = {
        "batch" => [
          "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
          "username"  => @configuration.username,
          "password"  => @configuration.password,
          "filename"  => @filename,
          "job"       => @job.to_hash,
        ]
      }
      XmlSimple.xml_out xml, {"RootName"=>"xml"}
    end
  end
end
