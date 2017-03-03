require 'lenddo/errors/configuration'

module Lenddo
  class Configuration
    attr_accessor :access_key, :secret_key, :score_service, :network_service

    def initialize
      @access_key = nil
      @secret_key = nil
      @score_service = "https://scoreservice.lenddo.com"
      @network_service = "https://networkservice.lenddo.com"
    end

    def access_key
      raise Errors::Configuration, "access_key in the configuration is missing!" unless @access_key
      @access_key
    end

    def secret_key
      raise Errors::Configuration, "secret_key in the configuration is missing!" unless @secret_key
      @secret_key
    end
  end
end