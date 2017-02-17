module Lenddo
  module ServiceClient
    class ScoreService
      attr_accessor :host

      def initialize
        @host = "https://scoreservice.lenddo.com"
      end

      def application_score(application_id, partnerscript_id)
        signed_request(
            "GET",
            host,
            "/ClientScore/#{application_id}",
            { partner_script_id: partnerscript_id }
        )
      end

      def application_verification(application_id, partnerscript_id)
        signed_request(
            "GET",
            host,
            "/ClientVerification/#{application_id}",
            { partner_script_id: partnerscript_id }
        )
      end
    end
  end
end