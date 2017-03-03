module Lenddo
  module WhiteLabelClient
    class NetworkService
      def extra_application_data(application_id, partnerscript_id, extra_data)
        response = signed_request(
            "POST",
            Lenddo.configuration.network_service,
            "/ExtraApplicationData",
            { "application_id" => application_id, "partner_script_id" => partnerscript_id, "extra_data" => extra_data }
        )
        JSON.parse(response.body)
      end

      def partner_token(application_id, provider, token_data, oauth_key, oauth_secret)
        body = { "token_data" => { "key" => oauth_key, "secret" => oauth_secret }, "provider" => provider, "client_id" => application_id }
        body['token_data'].merge!(token_data)
        response = signed_request(
          "POST",
          Lenddo.configuration.network_service,
          "/PartnerToken",
          body
        )
        JSON.parse(response.body)
      end

      def commit_partner_job(partnerscript_id, application_id, profile_ids, verification)
        response = signed_request(
          "POST",
          Lenddo.configuration.network_service,
          "/CommitPartnerJob",
          { "client_id" => application_id, "profile_ids" => profile_ids, "partner_script_id" => partnerscript_id, "verification_data" => verification}
        )
        JSON.parse(response.body)
      end
    end
  end
end