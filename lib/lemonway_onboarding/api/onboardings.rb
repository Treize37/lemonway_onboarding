# frozen_string_literal: true

module LemonwayOnboarding
  module Api
    # Onboardings API for Lemonway Onboarding
    class Onboardings
      # Initializes the Onboardings API with a client.
      #
      # @param client [LemonwayOnboarding::Client] The client to use for API requests
      # @return [LemonwayOnboarding::Api::Onboardings] The initialized
      def initialize(client = LemonwayOnboarding::Client.new)
        @client = client
      end

      # Creates a new onboarding process.
      #
      # @param type [String] The type of onboarding to create
      # @param body [Hash] The body of the request containing onboarding details
      def create(type, body)
        @client.post("onboardings/#{type}", body)
      end

      # Resumes an existing onboarding process.
      #
      # @param id [String] The ID of the onboarding process to resume
      # @return [Array<Hash>] The list of onboardings
      def update(id)
        @client.get("onboardings/#{id}/resume")
      end
    end
  end
end
