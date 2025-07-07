require 'spec_helper'
require 'lemonway_onboarding/api/documents'

RSpec.describe LemonwayOnboarding::Api::Documents do
  let(:client) { instance_double(LemonwayOnboarding::Client) }
  subject(:documents_api) { described_class.new(client) }

  describe '#get' do
    it 'calls client.get with the correct account id and document name' do
      expect(client).to receive(:get).with('accounts/789/documents/identity')
      documents_api.get(789, 'identity')
    end
  end

  describe '#update' do
    it 'calls client.post with the correct onboarding id and body' do
      expect(client).to receive(:post).with('legal_entity_onboarding/321/document', { foo: 'bar' })
      documents_api.update(321, { foo: 'bar' })
    end
  end
end
