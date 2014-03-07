module Click2Mail
  class RequestTrackingResult
    attr_accessor :tracking_results

    def initialize(response_body_hash)
      parse response_body_hash
    end

    def parse(response_body_hash)
      return if response_body_hash.empty?

      array_of_tracking_results = response_body_hash[:request_tracking_response][:request_tracking_result]
      if array_of_tracking_results.nil?
        @tracking_results = []
        return
      end

      @tracking_results = array_of_tracking_results.collect do |tracking_result|
        Click2Mail::TrackingResult.new(tracking_result)
      end
    end
  end
end
