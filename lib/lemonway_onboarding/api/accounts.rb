# frozen_string_literal: true

module LemonwayOnboarding
  module Api
    # Accounts API for Lemonway Onboarding
    class Accounts
      # Initializes the Accounts API with a client.
      #
      # @param client [LemonwayOnboarding::Client] The client to use for API requests
      # @return [LemonwayOnboarding::Api::Accounts] The initialized Accounts API
      def initialize(client = LemonwayOnboarding::Client.new)
        @client = client
      end

      # Creates a new account.
      #
      # @param type [String] The type of account to create
      # @param body [Hash] The body of the request containing account details
      # @return [Hash] The response from the API containing the created account details
      def create(type, body)
        @client.post("accounts/#{type}", body)
      end

      # Lists all accounts.
      #
      # @param params [Hash] Optional parameters to filter the accounts
      # @return [Array<Hash>] The list of accounts
      def index(params = {})
        @client.get('accounts', params)
      end

      # Retrieves a specific account by its ID.
      #
      # @param id [String] The ID of the account to retrieve
      # @return [Hash] The details of the specified account
      def show(id)
        @client.get("accounts/#{id}")
      end
    end
  end
end
