require "lenddo/authentication"
require "lenddo/service_client/score_service"

include Lenddo::Authentication

module Lenddo
  module ServiceClient
    class << self
      attr_accessor :score_service
      # Calls the Lenddo Service with the provided application_id to return a application score result.
      # @param string application_id
      # @param string partner_script_id
      def application_score(application_id, partnerscript_id)
        @score_service ||= ScoreService.new
        @score_service.application_score(application_id, partnerscript_id)
      end
      # Calls the Lenddo Service with the provided application id to return a application verification result.
      # @param string application_id
      # @param string partner_script_id
      def application_verification(application_id, partnerscript_id)
        @score_service ||= ScoreService.new
        @score_service.application_verification(application_id, partnerscript_id)
      end
      # Calls the Lenddo Service with the provided application id to return a application decision result.
      # @param string application_id
      # @param string partner_script_id
      def application_decision(application_id, partnerscript_id)
        @score_service ||= ScoreService.new
        @score_service.application_decision(application_id, partnerscript_id)
      end
    end
  end
end