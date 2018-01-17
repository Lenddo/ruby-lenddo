require "lenddo/authentication"
require "spec_helper"

include Lenddo::Authentication

RSpec.describe Lenddo::Authentication do
  before :all do
    Lenddo.configure do |config|
      config.access_key = ENV['ACCESS_KEY']
      config.secret_key = ENV['SECRET_KEY']
    end
  end

  describe "#signed_request" do
    it "behave like" do
      expect(Lenddo::Authentication).to receive(:signed_request).with("GET", Lenddo.configuration.score_service, "/ApplicationScore/#{ENV['APPLICATION_ID']}", { partner_script_id: ENV['PARTNERSCRIPT_ID'] })
      Lenddo::Authentication.signed_request("GET", Lenddo.configuration.score_service, "/ApplicationScore/#{ENV['APPLICATION_ID']}", { partner_script_id: ENV['PARTNERSCRIPT_ID'] })
    end

    it "response like" do
      response = signed_request(
        method: "GET",
        host: Lenddo.configuration.score_service,
        path: "/ApplicationScore/#{ENV['APPLICATION_ID']}",
        params: {
          partner_script_id: ENV['PARTNERSCRIPT_ID']
        }
      )
      expect(response.status).to eq('200 OK')
      expect(response.response_code).to eq(200)
      expect(response.body).to be_a(String)
    end
  end
 end