require "lenddo/authentication"
require "spec_helper"

RSpec.describe Lenddo::Authentication do
  before :all do
    Lenddo.configure do |config|
      config.access_key = ENV['ACCESS_KEY']
      config.secret_key = ENV['SECRET_KEY']
    end
  end

  it "#signed_request" do
    expect(Lenddo::Authentication).to receive(:signed_request).with("GET", Lenddo.configuration.score_service, "/ApplicationScore/TESTiz6q0wrl", { partner_script_id: "58a40b3a5a590f164d0b6383" })
    Lenddo::Authentication.signed_request("GET", Lenddo.configuration.score_service, "/ApplicationScore/TESTiz6q0wrl", { partner_script_id: "58a40b3a5a590f164d0b6383" })
  end
 end