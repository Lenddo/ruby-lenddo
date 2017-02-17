require 'base64'
require 'curb'
require 'openssl'

module Lenddo
  module Authentication
    def signed_request(method, host, path, params={})
      uri = URI.parse(host + path)

      method = method.downcase
      if (method == 'post' || method == 'put')
        body = params
      else
        body = {}
      end

      Curl.send(method.to_s, uri.to_s, params) do |http|
        headers = sign(method.upcase, path, body)
        headers.each do |key, value|
          http.headers[key] = value.chomp
        end

        http.use_ssl = 3
        http.ssl_verify_host = OpenSSL::SSL::VERIFY_PEER
        http.cacert = File.absolute_path("./cacert.pem") if RbConfig::CONFIG['host_os'] == 'mingw32'
      end
    end

    private
    def sign(verb, path, body, ts = nil)
      date_format = "%a %b %d %H:%M:%S %Z %Y"
      digest = body.empty? ? "" : Digest::MD5.hexdigest(body)
      timestamp = ts.nil? ? Time.now : Time.parse(ts, date_format)
      date = timestamp.strftime(date_format)
      text = [verb, digest, date, path].join("\n")
      puts text
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