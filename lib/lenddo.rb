require "lenddo/configuration"
require "lenddo/version"

module Lenddo
  class << self
    attr_accessor :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration) if block_given?
    end
  end
end