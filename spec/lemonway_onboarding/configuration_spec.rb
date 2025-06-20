require 'spec_helper'
require 'lemonway_onboarding/configuration'

# rubocop::disable Metrics/BlockLength
RSpec.describe LemonwayOnboarding::Configuration do
  subject(:config) { described_class.new }

  describe 'accessors' do
    it 'allows reading and writing base_url' do
      config.base_url = 'https://custom-url.com'
      expect(config.base_url).to eq('https://custom-url.com')
    end

    it 'allows reading and writing token' do
      config.token = 'my_token'
      expect(config.token).to eq('my_token')
    end

    it 'allows reading and writing version' do
      config.version = 'v2'
      expect(config.version).to eq('v2')
    end

    it 'allows reading and writing environment' do
      config.environment = 'sandbox'
      expect(config.environment).to eq('sandbox')
    end

    it 'allows reading and writing proxy' do
      config.proxy = 'http://proxy.example.com'
      expect(config.proxy).to eq('http://proxy.example.com')
    end

    it 'allows reading and writing timeout' do
      config.timeout = 99
      expect(config.timeout).to eq(99)
    end
  end

  describe '#initialize' do
    it 'sets the default version to v1' do
      expect(config.version).to eq('v1')
    end

    it 'sets the default timeout to 30' do
      expect(config.instance_variable_get(:@timeout)).to eq(30)
    end

    it 'sets the token to nil by default' do
      expect(config.token).to be_nil
    end

    it 'sets the proxy to nil by default' do
      expect(config.instance_variable_get(:@proxy)).to be_nil
    end

    it 'sets env to production by default' do
      expect(config.instance_variable_get(:@environment)).to eq('production')
    end

    it 'sets the base_url according to env' do
      expect(config.base_url).to eq('https://onboarding-api.lemonway.com')
    end
  end

  describe 'sandbox environment' do
    around do |example|
      original_env = ENV['LEMONWAY_ONBOARDING_ENV']
      ENV['LEMONWAY_ONBOARDING_ENV'] = 'sandbox'
      example.run
      ENV['LEMONWAY_ONBOARDING_ENV'] = original_env
    end

    it 'sets the sandbox base_url' do
      sandbox_config = described_class.new
      expect(sandbox_config.base_url).to eq('https://onboarding-api.sandbox.lemonway.com')
    end
  end

  describe '#configure' do
    it 'allows configuration via a block' do
      config.configure do |c|
        c.token = 'abc'
      end
      expect(config.token).to eq('abc')
    end
  end

  describe '#validate!' do
    it 'raises an error if token is missing' do
      expect { config.validate! }.to raise_error(/token is missing/)
    end

    it 'does not raise an error if configuration is valid' do
      config.token = 'abc'
      expect { config.validate! }.not_to raise_error
    end
  end
end
# rubocop:enable Metrics/BlockLength
