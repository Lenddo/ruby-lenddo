module Lenddo
  class Response
    def initialize(http_response)
      @http_response = http_response
    end

    def status
      @http_response.status
    end

    def response_code
      @http_response.response_code
    end

    def body
      JSON.parse(@http_response.body)
    end
  end
end