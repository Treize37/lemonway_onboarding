require 'spec_helper'
require 'lemonway_onboarding/api/onboardings'

RSpec.describe LemonwayOnboarding::Api::Onboardings do
  let(:client) { instance_double(LemonwayOnboarding::Client) }
  subject(:onboardings_api) { described_class.new(client) }

  describe '#create' do
    it 'calls client.post with the correct endpoint and body' do
      expect(client).to receive(:post).with('onboardings/individual', { foo: 'bar' })
      onboardings_api.create('individual', { foo: 'bar' })
    end
  end

  describe '#update' do
    it 'calls client.get with the correct onboarding id' do
      expect(client).to receive(:get).with('onboardings/456/resume')
      onboardings_api.update(456)
    end
  end
end
