require "lenddo/white_label_client"
require "spec_helper"

RSpec.describe Lenddo::WhiteLabelClient do
  before :all do
    Lenddo.configure do |config|
      config.access_key = ENV['ACCESS_KEY']
      config.secret_key = ENV['SECRET_KEY']
    end
  end

  it "#extra_application_data" do
    expect(Lenddo::WhiteLabelClient).to receive(:extra_application_data).with("application_id", "partnerscript_id", {})
    Lenddo::WhiteLabelClient.extra_application_data("application_id","partnerscript_id", {})
  end

  it "#partner_token" do
    expect(Lenddo::WhiteLabelClient).to receive(:partner_token).with("application_id","provider", token_data = Array.new, "oauth_key", "oauth_secret")
    Lenddo::WhiteLabelClient.partner_token("application_id","provider", [], "oauth_key", "oauth_secret")
  end

  it "#commit_partner_job" do
    expect(Lenddo::WhiteLabelClient).to receive(:commit_partner_job).with("partnerscript_id", "application_id", profile_ids = Array.new, verification = nil)
    Lenddo::WhiteLabelClient.commit_partner_job("partnerscript_id", "application_id", [], nil)
  end
end