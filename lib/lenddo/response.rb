require 'lenddo/errors/exceptions'

module Lenddo
  class Response
    def initialize(http_response)
      @http_response = http_response
      @parsed_response = nil

      http_code = http_response.response_code
      if http_code == 500
        raise Lenddo::Errors::InternalErrorException
      elsif http_code > 500
        raise Lenddo::Errors::UnknownException.new(http_response.status)
      end

      begin
        @parsed_response = JSON.parse(@http_response.body)
      rescue => e
        raise Lenddo::Errors::UnknownException.new(e.message)
      end
    end

    def status
      @http_response.status
    end

    def response_code
      @http_response.response_code
    end

    def body
      @parsed_response
    end
  end
end
