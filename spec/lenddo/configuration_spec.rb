require "lenddo"
require "spec_helper"

RSpec.describe Lenddo::Configuration do
  describe "#new" do
    let(:configuration) { Lenddo::Configuration.new }

    it "instantiate the class" do
      expect(configuration.instance_variable_get(:@access_key)).to be nil
      expect(configuration.instance_variable_get(:@secret_key)).to be nil
      expect(configuration.instance_variable_get(:@score_service)).to eq('https://scoreservice.lenddo.com')
      expect(configuration.instance_variable_get(:@network_service)).to eq('https://networkservice.lenddo.com')
    end

    it "create instance methods" do
      methods = Lenddo::Configuration.instance_methods(false)
      expect(methods).to contain_exactly(:access_key, :access_key=, :secret_key, :secret_key= ,:score_service, :score_service=, :network_service, :network_service=)
    end
  end
end