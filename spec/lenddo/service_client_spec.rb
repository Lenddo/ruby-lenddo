require "lenddo/service_client"
require "spec_helper"

RSpec.describe Lenddo::ServiceClient do
  before :all do
    Lenddo.configure do |config|
      config.access_key = ENV['ACCESS_KEY']
      config.secret_key = ENV['SECRET_KEY']
    end
  end

  describe "#application_score" do
    it "behave like" do
      expect(Lenddo::ServiceClient).to receive(:application_score).with("application_id", "partnerscript_id")
      Lenddo::ServiceClient.application_score("application_id", "partnerscript_id")
    end

    it "response like" do
      score = Lenddo::ServiceClient.application_score("application_id", "partnerscript_id")
      expect(score).to be_a(Hash)
    end
  end

  describe "#application_multiple_scores" do
    it "behave like" do
      expect(Lenddo::ServiceClient).to receive(:application_multiple_scores).with("application_id", "partnerscript_id")
      Lenddo::ServiceClient.application_multiple_scores("application_id", "partnerscript_id")
    end

    it "response like" do
      score = Lenddo::ServiceClient.application_multiple_scores("application_id", "partnerscript_id")
      expect(score).to be_a(Hash)
    end
  end

  describe "#application_verification" do
    it "behave like" do
      expect(Lenddo::ServiceClient).to receive(:application_verification).with("application_id", "partnerscript_id")
      Lenddo::ServiceClient.application_verification("application_id", "partnerscript_id")
    end

    it "response like" do
      verification = Lenddo::ServiceClient.application_verification("application_id", "partnerscript_id")
      expect(verification).to be_a(Hash)
    end
  end

  describe "application_decision" do
    it "behave like" do
      expect(Lenddo::ServiceClient).to receive(:application_decision).with("application_id", "partnerscript_id")
      Lenddo::ServiceClient.application_decision("application_id", "partnerscript_id")
    end

    it "response like" do
      decision = Lenddo::ServiceClient.application_decision("application_id", "partnerscript_id")
      expect(decision).to be_a(Hash)
    end
  end
end