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
      if @http_response.code >= 500
        # Will just prettify the #status it will
        # remove the http code and titleize the message.
        # 404 NOT FOUND => Not Found
        error = http_response.status.gsub(/^[0-9]{3}\s/, '').split(' ')
        error = error.map { |word| word.capitalize }.join(' ')
        return {
          "statusCode": @http_response.response_code,
          "error": error,
          "message": @http_response.status
        }
      end
      return JSON.parse(@http_response.body)
    end
  end
end
