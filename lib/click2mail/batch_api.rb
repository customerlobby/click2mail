module Click2Mail
  class BatchAPI
    def initialize(configuration)
      @configuration = configuration
    end

    def create
      # curl -X POST https://{username}:{password}@batch.click2mail.com/v1/batches
      url = BatchAPI.build_base_url(@configuration)

      response = BatchAPI.submit_url(url)

      return handle_response(response)
    end

    def upload_xml(batch_id, xml)
      # curl -X PUT https://{username}:{password}@batch.click2mail.com/v1//batches/{batch_id} -H "Content-Type: application/xml" --data-binary "@{filename_of_xml}"
      url = "#{BatchAPI.build_base_url(@configuration)}/#{batch_id}"
      content_type = :xml
      response = BatchAPI.submit_stream(url, xml, content_type)

      return handle_response(response)
    end

    def upload_pdf(batch_id, pdf)
      # curl -X PUT http://{username}:{password}@batch.click2mail.com/v1/batches/{batch_id} -H "Content-Type: application/pdf" --data-binary "@{filename_of_pdf}"
      url = "#{BatchAPI.build_base_url(@configuration)}/#{batch_id}"
      content_type = :pdf
      response = BatchAPI.submit_stream(url, File.open(pdf,'rb'), content_type)

      return handle_response(response)
    end

    def submit(batch_id)
      # curl -X POST http://{username}:{password}@batch.click2mail.com/v1/batches/{batch_id}
      url = "#{BatchAPI.build_base_url(@configuration)}/#{batch_id}"

      response = BatchAPI.submit_url(url)

      return handle_response(response)
    end

    def status(batch_id)
      # curl GET http://{username}:{password}@batch.click2mail.com/v1/batches/{batch_id}
      url = "#{BatchAPI.build_base_url(@configuration)}/#{batch_id}"

      response = RestClient.get url

      return handle_response(response)
    end

    def self.create_batch(configuration, xml, pdf)
      c2m = Click2Mail.new(configuration)
      batch_response = c2m.create

      c2m.upload_xml batch_response.id, xml
      c2m.upload_pdf batch_response.id, pdf

      submit batch_response.id

      return batch_response
    end

    private

    def handle_response(response)
      case response.code
      when 200
        return "SUCCESS"
      when 201
        return Click2Mail::BatchResponse.new(response.body)
      when 400
        puts "Error: #{response.body}"
        return 'ERROR'
    end
    end

    def self.build_base_url(configuration)
      username = configuration.username
      password = configuration.password
      target   = configuration.batch_target

      return "https://#{username}:#{password}@#{target}.click2mail.com/v1/batches"
    end

    def self.submit_url(url)
      response = RestClient.post url, nil

      return response
    end

    def self.submit_stream(url, stream, content_type)
      begin
        response = RestClient.put url, stream.read, :content_type=>content_type
      rescue => e
        response = e.response
      end

      return response
    end
  end
end
