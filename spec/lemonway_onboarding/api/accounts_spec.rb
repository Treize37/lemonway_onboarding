require 'spec_helper'
require 'lemonway_onboarding/api/accounts'

RSpec.describe LemonwayOnboarding::Api::Accounts do
  let(:client) { instance_double(LemonwayOnboarding::Client) }
  subject(:accounts_api) { described_class.new(client) }

  describe '#create' do
    it 'calls client.post with the correct endpoint and body' do
      expect(client).to receive(:post).with('accounts/business', { foo: 'bar' })
      accounts_api.create('business', { foo: 'bar' })
    end
  end

  describe '#index' do
    it 'calls client.get with the correct endpoint and params' do
      expect(client).to receive(:get).with('accounts', { status: 'active' })
      accounts_api.index({ status: 'active' })
    end
  end

  describe '#show' do
    it 'calls client.get with the correct account id' do
      expect(client).to receive(:get).with('accounts/123')
      accounts_api.show(123)
    end
  end
end
