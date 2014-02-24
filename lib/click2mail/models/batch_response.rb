class BatchResponse
  attr_accessor :id,
                :status,
                :description,
                :statusurl
  def initialize(batch_response_xml='')
    parse(batch_response_xml)
  end

  def parse(batch_response_xml='')
    return if batch_response_xml.empty?

    puts batch_response_xml

    @id = -1
    @status = 'temporary'
    @description = "Josh's mock"
    @statusurl = "http://joshuavolz.com/"
  end
end
