module Lenddo
  class Configuration
    attr_accessor :access_key, :secret_key

    def initialize
      @access_key = nil
      @secret_key = nil
    end
  end
end