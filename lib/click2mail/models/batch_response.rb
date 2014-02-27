class BatchResponse
  attr_accessor :id,
                :created_at,
                :error_message,
                :has_errors,
                :received,
                :submitted
  def initialize(batch_response_xml='')
    parse(batch_response_xml)
  end

  def parse(batch_response_xml='')
    return if batch_response_xml.empty?

    data = XmlSimple.xml_in(batch_response_xml)

    @id =            data["id"].first.to_i
    @created_at =    Date.parse(data["createdAt"].first)
    @error_message = data["errorMessage"]
    @has_errors =    data["hasErrors"] == "true"
    @received =      data["received"] == "true"
    @submitted =     data["submitted"] == "true"
  end
end
