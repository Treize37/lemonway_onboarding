# frozen_string_literal: true

module LemonwayOnboarding
  module Api
    class Documents
      def initialize(client = LemonwayOnboarding::Client.new)
        @client = client
      end

      def get(account_id, document_name)
        @client.get("accounts/#{account_id}/documents/#{document_name}")
      end

      def update(onboarding_id, body)
        @client.post("legal_entity_onboarding/#{onboarding_id}/document", body)
      end
    end
  end
end
