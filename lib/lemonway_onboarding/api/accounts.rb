# frozen_string_literal: true

module LemonwayOnboarding
  module Api
    class Accounts
      def initialize(client = LemonwayOnboarding::Client.new)
        @client = client
      end

      def create(type, body)
        @client.post("accounts/#{type}", body)
      end

      def index(params = {})
        @client.get('accounts', params)
      end

      def show(id)
        @client.get("accounts/#{id}")
      end
    end
  end
end
