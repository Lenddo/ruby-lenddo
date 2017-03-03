module Lenddo
  module ServiceClient
    class ScoreService
      def application_score(application_id, partnerscript_id)
        response = signed_request(
          "GET",
          Lenddo.configuration.score_service,
          "/ClientScore/#{application_id}",
          { "partner_script_id" => partnerscript_id }
        )
        JSON.parse(response.body)
      end

      def application_verification(application_id, partnerscript_id)
        response = signed_request(
          "GET",
          Lenddo.configuration.score_service,
          "/ClientVerification/#{application_id}",
          { "partner_script_id" => partnerscript_id }
        )
        JSON.parse(response.body)
      end

      def application_decision(application_id, partnerscript_id)
        response = signed_request(
          "GET",
          Lenddo.configuration.score_service,
          "/ApplicationDecision/#{application_id}",
          { "partner_script_id" => partnerscript_id}
        )
        JSON.parse(response.body)
      end
    end
  end
end