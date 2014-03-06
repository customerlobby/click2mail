module Click2mail
  class BatchResponse
    attr_accessor :id,
                  :created_at,
                  :error_message,
                  :has_errors,
                  :received,
                  :submitted,
                  :jobStatuses

    def initialize(batch_response_xml='')
      parse(batch_response_xml)
    end

    def parse(batch_response_xml='')
      return if batch_response_xml.empty?

      data = XmlSimple.xml_in(batch_response_xml)

      puts data

      @id =            data["id"].first.to_i
      @created_at =    Date.parse(data["createdAt"].first)
      @error_message = data["errorMessage"].first
      @has_errors =    data["hasErrors"].first == "true"
      @received =      data["received"].first == "true"
      @submitted =     data["submitted"].first == "true"

      if data.has_key?("jobs")
        @jobStatuses = data["jobs"].map do |job_status|
          JobStatus.new({
            :invoice    => job_status["invoice"],
            :job_id     => job_status["jobId"],
            :job_status => job_status["jobStatus"],
          })
        end
      end
    end
  end
end
