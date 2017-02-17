require "lenddo/authentication"
require "lenddo/service_client/score_service"

include Lenddo::Authentication

module Lenddo
  module ServiceClient
    class << self
      attr_accessor :score_service

      def application_score(application_id, partnerscript_id)
        @score_service ||= ScoreService.new
        @score_service.application_score(application_id, partnerscript_id)
      end

      def application_verification(application_id, partnerscript_id)
        @score_service ||= ScoreService.new
        @score_service.application_verification(application_id, partnerscript_id)
      end
    end
  end
end