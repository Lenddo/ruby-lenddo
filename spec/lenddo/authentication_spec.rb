require "lenddo/authentication"
require "lenddo/errors/exceptions"
require "spec_helper"
require "curb"

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

  describe "custom exceptions" do
    it "should raise Lenddo::Errors::HostResolutionError" do
      expect {
        Lenddo::Authentication.signed_request(
          method: "GET",
          host: "http://balhkdsad",
          path: "/ClientScore/",
          params: {
            partner_script_id: 'test'
          }
        )
      }.to raise_error(Lenddo::Errors::HostResolutionError)
    end

    it "should raise Lenddo::Errors::TimeoutException" do
      allow(Curl).to receive(:send).and_raise(Curl::Err::TimeoutError)
      expect {
        Lenddo::Authentication.signed_request(
          method: "GET",
          host: "http://balhkdsad",
          path: "/ClientScore/",
          params: {
            partner_script_id: 'test'
          }
        )
      }.to raise_error(Lenddo::Errors::TimeoutException)
    end

    it "should raise Lenddo::Errors::UnknownException" do
      allow(Curl).to receive(:send).and_raise(IOError)
      expect {
        Lenddo::Authentication.signed_request(
          method: "GET",
          host: "http://balhkdsad",
          path: "/ClientScore/",
          params: {
            partner_script_id: 'test'
          }
        )
      }.to raise_error(Lenddo::Errors::UnknownException)
    end

    it "should raise Lenddo::Errors::InternalErrorException on HTTP 500" do
      expect {
        Lenddo::Authentication.signed_request(
          method: "GET",
          host: "http://httpstat.us",
          path: "/500",
          params: {
            partner_script_id: 'test'
          }
        )
      }.to raise_error(Lenddo::Errors::InternalErrorException)
    end

    it "should raise Lenddo::Errors::UnknownException on > HTTP 500" do
      expect {
        Lenddo::Authentication.signed_request(
          method: "GET",
          host: "http://httpstat.us",
          path: "/502",
          params: {
            partner_script_id: 'test'
          }
        )
      }.to raise_error(Lenddo::Errors::UnknownException)
    end

  end
 end
