require "lenddo/authentication"
require "lenddo/service_client/score_service"

include Lenddo::Authentication

module Lenddo
  module ServiceClient
    class << self
      attr_accessor :network_service

      def valid_token_providers
        ['Facebook', 'LinkedIn', 'Yahoo', 'WindowsLive', 'Google']
      end

      # Posting network tokens, if successful, returns a "Profile ID" which is used when submitting a client for scoring.
      # @param string application_id
      # @param string provider
      # @param string oauth_key
      # @param string oauth_secret (optional)
      # @param array token_data
      def partner_token(application_id, provider, oauth_key, oauth_secret = nil, token_data)
        @network_service ||= NetworkService.new

        if !valid_token_provider.include?(provider)
          raise InvalidArgumentError.new("@provider must be one of the following: #{valid_token_providers.join(", ")}")
        else
          @network_service.partner_token(application_id, provider, oauth_key, oauth_secret, token_data)
        end
      end

      # Submit an application with profile ids for scoring to Lenddo.
      # To perform this step you must have an array of at least one profile id obtained from the PartnerToken call.
      # @param string partner_script_id
      # @param string application_id
      # @param array profile_ids
      # @param verification - Optional
      def commit_partner_job(partnerscript_id, application_id, profile_ids, verification = nil)
        @network_service ||= NetworkService.new

        if profile_ids.empty?
          raise InvalidArgumentError.new("@profile_ids must contain at least one entry.")
        elsif profile_ids.class != Array
          raise InvalidArgumentError.new("@profile_ids must be an array.")
        else
          @network_service.commit_partner_job(partnerscript_id, application_id, profile_ids, verification)
        end
      end
    end
  end
end