require "lenddo/white_label_client"
require "spec_helper"

RSpec.describe Lenddo::WhiteLabelClient do
  before :all do
    Lenddo.configure do |config|
      config.access_key = ENV['ACCESS_KEY']
      config.secret_key = ENV['SECRET_KEY']
    end
  end

  describe "#extra_application_data" do
    it "behave like" do
      expect(Lenddo::WhiteLabelClient).to receive(:extra_application_data).with("application_id", "partnerscript_id", {})
      Lenddo::WhiteLabelClient.extra_application_data("application_id","partnerscript_id", {})
    end

    it "response like" do
      extra_application_data = Lenddo::WhiteLabelClient.extra_application_data("application_id","partnerscript_id", {})
      expect(extra_application_data).to be_a(Hash)
    end
  end

  describe "#partner_token" do
    it "behave like" do
      expect(Lenddo::WhiteLabelClient).to receive(:partner_token).with("application_id","provider", token_data = Hash.new, "oauth_key", "oauth_secret")
      Lenddo::WhiteLabelClient.partner_token("application_id","provider", {}, "oauth_key", "oauth_secret")
    end

    it "response like" do
      partner_token = Lenddo::WhiteLabelClient.partner_token("application_id","Facebook", { "rspec" => "great"}, "oauth_key", "oauth_secret")
      expect(partner_token).to be_a(Hash)
    end
  end

  describe "#commit_partner_job" do
    it "behave like" do
      expect(Lenddo::WhiteLabelClient).to receive(:commit_partner_job).with("partnerscript_id", "application_id", profile_ids = Array.new, verification = nil)
      Lenddo::WhiteLabelClient.commit_partner_job("partnerscript_id", "application_id", [], nil)
    end

    it "response like" do
      commit_partner_job = Lenddo::WhiteLabelClient.commit_partner_job("partnerscript_id", "application_id", ["ruby@lenddo.com"], nil)
      expect(commit_partner_job).to be_a(Hash)
    end
  end
end