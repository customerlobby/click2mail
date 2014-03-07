module Click2Mail
  class MolPro
    def initialize(configuration)
      @configuration = configuration
    end

    def request_tracking(job_id)
      url = "https://#{@configuration.soap_target}.click2mail.com/molpro.asmx?wsdl"

      client = Savon.client(wsdl: url)

      message = {
        "client_app_id"  => @configuration.username,
        "client_app_pwd" => @configuration.password,
        "jobId"          => job_id,
      }
      response = client.call(:request_tracking, message: message)

      return Click2Mail::RequestTrackingResult.new(response.body)
    end
  end
end
