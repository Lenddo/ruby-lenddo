module Lenddo
  class ScoreService
    def application_score(application_id, partnerscript_id)
      signed_request(
        method: "GET",
        host: Lenddo.configuration.score_service,
        path: "/ClientScore/#{application_id}",
        params: {
          partner_script_id: partnerscript_id
        }
      )
    end

    def application_multiple_scores(application_id, partnerscript_id)
      signed_request(
        method: "GET",
        host: Lenddo.configuration.score_service,
        path: "/ApplicationMultipleScores/#{application_id}",
        params: {
          partner_script_id: partnerscript_id
        }
      )
    end

    def application_verification(application_id, partnerscript_id)
      signed_request(
        method: "GET",
        host: Lenddo.configuration.score_service,
        path: "/ClientVerification/#{application_id}",
        params: {
          partner_script_id: partnerscript_id
        }
      )
    end

    def application_decision(application_id, partnerscript_id)
      signed_request(
        method: "GET",
        host: Lenddo.configuration.score_service,
        path: "/ApplicationDecision/#{application_id}",
        params: {
          partner_script_id: partnerscript_id
        }
      )
    end
  end
end