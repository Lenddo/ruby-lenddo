module Lenddo
  module Errors
    class TimeoutException < StandardError; end
    class UnknownException < StandardError; end
    class HostResolutionError < StandardError; end
    class InternalErrorException < StandardError; end
  end
end
