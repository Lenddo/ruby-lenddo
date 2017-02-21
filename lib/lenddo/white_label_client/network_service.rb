module Lenddo
  module ServiceClient
    class NetworkService
      attr_accessor :host

      def initialize
        @host = "https://networkservice.lenddo.com"
      end

      def partner_token(application_id, provider, oauth_key, oauth_secret, token_data)
        signed_request(
            "POST",
            host,
            "/PartnerToken",
            { token_data: { key: oauth_key, secret: oauth_secret }, provider: provider, client_id: application_id }
        )
      end

      def commit_partner_job(partnerscript_id, application_id, profile_ids, verification = nil)
        signed_request(
            "POST",
            host,
            "/CommitPartnerJob",
            { client_id: application_id, profile_ids: profile_ids, partner_script_id: partnerscript_id, verification_data: verification}
        )
      end
    end
  end
end