module Lenddo
  class InvalidArgumentError < StandardError
    def initialize(msg)
      super
    end
  end
end