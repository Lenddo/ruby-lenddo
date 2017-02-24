require "lenddo/service_client"
require "spec_helper"

RSpec.describe Lenddo::ServiceClient do
  before :all do
    Lenddo.configure do |config|
      config.access_key = ENV['ACCESS_KEY']
      config.secret_key = ENV['SECRET_KEY']
    end
  end

  it "#application_score" do
    expect(Lenddo::ServiceClient).to receive(:application_score).with("application_id", "partnerscript_id")
    Lenddo::ServiceClient.application_score("application_id", "partnerscript_id")
  end

  it "#application_veriifcation" do
    expect(Lenddo::ServiceClient).to receive(:application_verification).with("application_id", "partnerscript_id")
    Lenddo::ServiceClient.application_verification("application_id", "partnerscript_id")
  end

  it "#application_decision" do
    expect(Lenddo::ServiceClient).to receive(:application_decision).with("application_id", "partnerscript_id")
    Lenddo::ServiceClient.application_decision("application_id", "partnerscript_id")
  end
end