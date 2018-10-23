module Lenddo
  class NetworkService
    def mobile_data(partner_id, partnerscript_id)
      signed_request(
        method: "GET",
        host: Lenddo.configuration.network_service,
        path: "/MobileData",
        params: {
          partner_id: partner_id,
          partner_script_id: partnerscript_id
        }
      )
    end

    def extra_application_data(application_id, partnerscript_id, extra_data)
      signed_request(
        method: "POST",
        host: Lenddo.configuration.network_service,
        path: "/ExtraApplicationData",
        params: {
          application_id: application_id,
          partner_script_id: partnerscript_id,
          extra_data: extra_data
        }.to_json
      )
    end

    def partner_token(application_id, provider, token_data, oauth_key, oauth_secret)
      signed_request(
        method: "POST",
        host: Lenddo.configuration.network_service,
        path: "/PartnerToken",
        params: {
          token_data: {
            key: oauth_key,
            secret: oauth_secret
          }.merge!(token_data),
          provider: provider,
          client_id: application_id
        }.to_json
      )
    end

    def commit_partner_job(partnerscript_id, application_id, profile_ids, verification)
      signed_request(
        method: "POST",
        host: Lenddo.configuration.network_service,
        path: "/CommitPartnerJob",
        params: {
          client_id: application_id,
          profile_ids: profile_ids,
          partner_script_id: partnerscript_id,
          verification_data: verification
        }.to_json
      )
    end
  end
end