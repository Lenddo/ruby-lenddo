require "lenddo"
require "spec_helper"

RSpec.describe Lenddo::Configuration do
  before :each do
    Lenddo.configure do |config|
      config.access_key = ENV['ACCESS_KEY']
      config.secret_key = ENV['SECRET_KEY']
    end
  end

  context 'with configuration block' do
    it 'returns the configuration' do
      expect(Lenddo.configuration.access_key).to eq(ENV['ACCESS_KEY'])
      expect(Lenddo.configuration.secret_key).to eq(ENV['SECRET_KEY'])
      expect(Lenddo.configuration.score_service).to eq(ENV['SCORE_SERVICE'])
      expect(Lenddo.configuration.network_service).to eq(ENV['NETWORK_SERVICE'])
    end
  end

  context 'without configuration block' do
    before do
      Lenddo.reset
    end

    it 'raises a configuration error for access_key and secret_key' do
      expect { Lenddo.configuration.access_key }.to raise_error(Lenddo::Errors::Configuration)
      expect { Lenddo.configuration.secret_key }.to raise_error(Lenddo::Errors::Configuration)
    end
  end

  context '#reset' do
    before do
      Lenddo.reset
    end

    it 'resets configuration values' do
      expect { Lenddo.configuration.access_key }.to raise_error(Lenddo::Errors::Configuration)
      expect { Lenddo.configuration.secret_key }.to raise_error(Lenddo::Errors::Configuration)
    end
  end
end