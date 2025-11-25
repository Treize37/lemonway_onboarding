# frozen_string_literal: true

module LemonwayOnboarding
  module Api
    # Profiles API for Lemonway Onboarding
    class Profiles
      # Initializes the Profiles API with a client.
      #
      # @param client [LemonwayOnboarding::Client] The client to use for API requests
      # @return [LemonwayOnboarding::Api::Profiles] The initialized Profiles API
      def initialize(client = LemonwayOnboarding::Client.new)
        @client = client
      end

      # Creates a new profile.
      #
      # @param type [String] The type of account
      # @param account_id [String] The ID of the account to associate the profile with
      # @param body [Hash] The body of the request containing profile details
      # @return [Hash] The response from the API containing the created profile details
      def create(type, account_id, body)
        @client.post("accounts/#{type}/#{account_id}/profiles", body)
      end
    end
  end
end
