require "lenddo"
require "lenddo/authentication"
require "lenddo/response"
require "lenddo/score_service/self"

include Lenddo::Authentication

module Lenddo
  module ServiceClient
    class << self
      attr_accessor :score_service
      # Calls the Lenddo Service with the provided application_id and partner_script_id to return a application score result.
      # @param string application_id
      # @param string partnerscript_id
      def application_score(application_id, partnerscript_id)
        @score_service ||= ScoreService.new
        Response.new @score_service.application_score(application_id, partnerscript_id)
      end
      # Calls the Lenddo Service with the provided application_id and partner_script_id to return an array of LenddoScore records
      # @param string application_id
      # @param string partnerscript_id
      def application_multiple_scores(application_id, partnerscript_id)
        @score_service ||= ScoreService.new
        Response.new @score_service.application_multiple_scores(application_id, partnerscript_id)
      end
      # Calls the Lenddo Service with the provided application_id and partner_script_idto return a application verification result.
      # @param string application_id
      # @param string partnerscript_id
      def application_verification(application_id, partnerscript_id)
        @score_service ||= ScoreService.new
        Response.new @score_service.application_verification(application_id, partnerscript_id)
      end
      # Calls the Lenddo Service with the provided application_id and partner_script_id to return a application decision result.
      # @param string application_id
      # @param string partnerscript_id
      def application_decision(application_id, partnerscript_id)
        @score_service ||= ScoreService.new
        Response.new @score_service.application_decision(application_id, partnerscript_id)
      end

      # Get mobile data using the partner_script_id
      # @param string partnerscript_id
      def mobile_data(partnerscript_id)
        @network_service ||= NetworkService.new
        Response.new @network_service.mobile_data(partnerscript_id)
      end
    end
  end
end