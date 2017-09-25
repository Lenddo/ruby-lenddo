require "lenddo/authentication"
require "lenddo/white_label_client/network_service"

include Lenddo::Authentication

module Lenddo
  module WhiteLabelClient
    class << self
      attr_accessor :network_service
      # Submit additional data about an application to Lenddo.
      # @param string application_id
      # @param string partnerscript_id
      # @param array extra_data
      def extra_application_data(application_id, partnerscript_id, extra_data = {})
        @network_service ||= NetworkService.new

        if extra_data.class != Hash
          raise ArgumentError.new("@extra_data must be a Hash.")
        else
          @network_service.extra_application_data(application_id, partnerscript_id, extra_data)
        end
      end
      # Posting network tokens, if successful, returns a "Profile ID" which is used when submitting a client for scoring.
      # @param string application_id
      # @param string provider
      # @param hash token_data
      # @param string oauth_key
      # @param string oauth_secret (optional)
      def partner_token(application_id, provider, token_data, oauth_key, oauth_secret = nil)
        @network_service ||= NetworkService.new

        if !valid_token_providers.include?(provider)
          raise ArgumentError.new("@provider must be one of the following: #{valid_token_providers.join(", ")}")
        else
          @network_service.partner_token(application_id, provider, token_data, oauth_key, oauth_secret)
        end
      end
      # Submit an application with profile ids for scoring to Lenddo.
      # To perform this step you must have an array of at least one profile id obtained from the PartnerToken call.
      # @param string partnerscript_id
      # @param string application_id
      # @param array profile_ids
      # @param verification - Optional
      def commit_partner_job(partnerscript_id, application_id, profile_ids, verification = nil)
        @network_service ||= NetworkService.new

        if profile_ids.empty?
          raise ArgumentError.new("@profile_ids must contain at least one entry.")
        elsif profile_ids.class != Array
          raise ArgumentError.new("@profile_ids must be an array.")
        else
          @network_service.commit_partner_job(partnerscript_id, application_id, profile_ids, verification)
        end
      end

      private
      def valid_token_providers
        ['Facebook', 'LinkedIn', 'Yahoo', 'WindowsLive', 'Google']
      end
    end
  end
end