require 'base64'
require 'curb'
require 'json'
require 'openssl'
require 'lenddo/errors/exceptions'

module Lenddo
  module Authentication
    def signed_request(args)
      host = args[:host]
      method = args[:method].downcase
      path = args[:path]
      params = args[:params]

      if (method == 'post' || method == 'put')
        body = params
      else
        body = {}
      end

      uri = URI.parse(host + path)
      begin
        response = Curl.send(method.to_s, uri.to_s, params) do |http|
          headers = sign(method.upcase, path, body)
          headers.each do |key, value|
            http.headers[key] = value.chomp
          end

          http.use_ssl = 3
          http.ssl_verify_host = OpenSSL::SSL::VERIFY_PEER
          http.cacert = File.absolute_path("./cacert.pem") if RbConfig::CONFIG['host_os'] == 'mingw32'
        end
      rescue Curl::Err::TimeoutError => e
        raise Lenddo::Errors::TimeoutException.new(e.message)
      rescue Curl::Err::HostResolutionError => e
        raise Lenddo::Errors::HostResolutionError.new(e.message)
      rescue => e
        raise Lenddo::Errors::UnknownException.new(e.message)
      end

      http_code = response.response_code
      if http_code == 500
        raise Lenddo::Errors::InternalErrorException
      elsif http_code > 500
        raise Lenddo::Errors::UnknownException.new(response.status)
      end

      response
    end

    private
    def sign(verb, path, body, ts = nil)
      date_format = "%a %b %d %H:%M:%S %Z %Y"
      digest = body.empty? ? "" : Digest::MD5.hexdigest(body)
      timestamp = ts.nil? ? Time.now : Time.parse(ts, date_format)
      date = timestamp.strftime(date_format)
      text = [verb, digest, date, path].join("\n")
      {
          'Authorization' => auth_string(text),
          'Content-Type' => 'application/json',
          'Date' => date
      }
    end

    def auth_string(text)
      hash = Base64.encode64(sha1_hmac(Lenddo.configuration.secret_key, text))
      "LENDDO #{Lenddo.configuration.access_key}:#{hash}"
    end

    def sha1_hmac(key, value)
      OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), key, value)
    end
  end
end
