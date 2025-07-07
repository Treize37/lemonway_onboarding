
# frozen_string_literal: true

module LemonwayOnboarding
  module Api
    # Documents API for Lemonway Onboarding
    class Documents
      # Initializes the Documents API with a client.
      #
      # @param client [LemonwayOnboarding::Client] The client to use for API requests
      # @return [LemonwayOnboarding::Api::Documents] The initialized Documents API
      def initialize(client = LemonwayOnboarding::Client.new)
        @client = client
      end

      # Retrieves a document for a specific account.
      #
      # @param account_id [String] The ID of the account to retrieve the document for
      # @param document_name [String] The name of the document to retrieve
      # @return [Hash] The response from the API containing the document details
      def get(account_id, document_name)
        @client.get("accounts/#{account_id}/documents/#{document_name}")
      end

      # Updates a document for a specific onboarding process.
      #
      # @param onboarding_id [String] The ID of the onboarding process
      # @param body [Hash] The body of the request containing document details
      # @return [Hash] The response from the API containing the updated document details
      def update(onboarding_id, body)
        @client.post("legal_entity_onboarding/#{onboarding_id}/document", body)
      end
    end
  end
end
