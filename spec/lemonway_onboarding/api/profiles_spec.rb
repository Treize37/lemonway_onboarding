# frozen_string_literal: true

require 'spec_helper'
require 'lemonway_onboarding/api/profiles'

RSpec.describe LemonwayOnboarding::Api::Profiles do
  let(:client) { instance_double(LemonwayOnboarding::Client) }
  subject(:profiles_api) { described_class.new(client) }
  describe '#create' do
    it 'calls client.post with the correct endpoint and body' do
      expect(client).to receive(:post).with('accounts/individual/123/profiles', { foo: 'bar' })
      profiles_api.create('individual', '123', { foo: 'bar' })
    end
  end
end
