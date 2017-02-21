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

      # Calls the Lenddo Service with the provided client id to return a client verification result.
      # @param string application_id
      # @param string partner_script_id
      def application_verification(application_id, partnerscript_id)
        @score_service ||= ScoreService.new
        @score_service.application_verification(application_id, partnerscript_id)
      end

      # @param string application_id
      # @param string partner_script_id
      def application_decision(application_id, partnerscript_id)
        @score_service ||= ScoreService.new
        @score_service.application_decision(application_id, partnerscript_id)
      end

      # Submit additional data about an application to Lenddo.
      # @param string application_id
      # @param string partner_script_id
      # @param array extra_data
      def extra_application_data(application_id, partnerscript_id, extra_data = {})
        @score_service ||= ScoreService.new

        if extra_data.class != Hash
          raise InvalidArgumentError.new("@extra_data must be a Hash.")
        else
          @score_service.extra_application_data(application_id, partnerscript_id, extra_data)
        end
      end
    end
  end
end