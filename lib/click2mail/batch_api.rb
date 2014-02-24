module Click2Mail
  class BatchAPI
    def initialize(configuration)
      @configuration = configuration
    end

    def create
      # curl -X POST https://{username}:{password}@batch.click2mail.com/v1/batches
      url = BatchAPI.build_base_url(@configuration)

      response = BatchAPI.submit_url(url)

      # TODO logging
      case response.code
      when 201
        return BatchResponse.new(response.body)
      when 400
        return 'ERROR'
      end
    end

    def upload_batch_xml(xml)
      # curl -X PUT https://{username}:{password}@batch.click2mail.com/v1//batches/{batch_id} -H "Content-Type: application/xml" --data-binary "@{filename_of_xml}"
      url = BatchAPI.build_base_url(@configuration)
      content_type = "application/xml"
      response = BatchAPI.submit_stream(url, xml, content_type)

      # TODO logging
      case response.code
      when 201
        return BatchResponse.new(response.body)
      when 400
        return 'ERROR'
      end
    end

    def upload_batch_pdf(pdf)
      # curl -X PUT http://{username}:{password}@batch.click2mail.com/v1/batches/{batch_id} -H "Content-Type: application/pdf" --data-binary "@{filename_of_pdf}"
      url = BatchAPI.build_base_url(@configuration)
      content_type = "application/xml"
      response = BatchAPI.submit_stream(url, pdf, content_type)

      # TODO logging
      case response.code
      when 201
        return BatchResponse.new(response.body)
      when 400
        return 'ERROR'
      end
    end

    def submit(batch_id)
      # curl -X POST http://{username}:{password}@batch.click2mail.com/v1/batches/{batch_id}
      url = "#{BatchAPI.build_base_url}(@configuration)/#{batch_id}"

      response = BatchAPI.submit_url(url)

      # TODO logging
      case response.code
      when 201
        return BatchResponse.new(response.body)
      when 400
        return 'ERROR'
      end
    end

    def self.create_batch(configuration, xml, pdf)
      c2m = Click2Mail.new(configuration)
      batch_id = c2m.create
      c2m.upload_batch_xml(xml)
      c2m.upload_batch_pdf(pdf)
      submit(batch_id)

      return batch_id
    end

    private

    def self.build_base_url(configuration)
      username = configuration.username
      password = configuration.password
      target   = configuration.target

      return "https://#{username}:#{password}@#{target}.click2mail.com/v1/batches"
    end

    def self.submit_url(url)
      puts "Submitting #{url}"
      response = RestClient.get url
      puts "Response: #{response}"

      return response
    end

    def self.submit_stream(url, stream, content_type)

    end
  end
end
