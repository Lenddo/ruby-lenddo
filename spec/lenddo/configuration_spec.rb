require 'spec_helper'

RSpec.describe Lenddo::Configuration do
  let(:configuration) { Lenddo::Configuration.new }

  describe "instance variable" do
    let(:access_key) { configuration.access_key }
    let(:secret_key) { configuration.secret_key }
    let(:score_service) { configuration.score_service }
    let(:network_service) { configuration.network_service }

    it "has default value" do
      expect(access_key).to be nil
      expect(secret_key).to be nil
      expect(score_service).to eq('https://scoreservice.lenddo.com')
      expect(network_service).to eq('https://networkservice.lenddo.com')
    end

    it "should be configurable" do
      
    end
  end
end