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

      def application_decision(application_id, partnersciprt_id)
        signed_request(
            "GET",
            host,
            "/ApplicationDecision/#{application_id}",
            { partner_script_id: partnersciprt_id}
        )
      end

      def extra_application_data(application_id, partnerscript_id, extra_data)
        signed_request(
            "POST",
            "https://networkservice.lenddo.com",
            "/ExtraApplicationData",
            { application_id: application_id, partner_script_id: partnerscript_id, extra_data: extra_data }
        )
      end
    end
  end
end