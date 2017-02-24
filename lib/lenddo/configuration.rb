module Lenddo
  class Configuration
    attr_accessor :access_key, :secret_key, :score_service, :network_service

    def initialize
      @access_key = nil
      @secret_key = nil
      @score_service = "https://scoreservice.lenddo.com"
      @network_service = "https://networkservice.lenddo.com"
    end
  end
end