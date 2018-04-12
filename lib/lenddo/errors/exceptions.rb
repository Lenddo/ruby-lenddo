module Lenddo
  module Errors
    class TimeoutException < StandardError; end
    class UnknownException < StandardError; end
    class HostResolutionError < StandardError; end
  end
end
