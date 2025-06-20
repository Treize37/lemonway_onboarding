# frozen_string_literal: true

module LemonwayOnboarding
  module Api
    class Onboardings
      def initialize(client = LemonwayOnboarding::Client.new)
        @client = client
      end

      def create(type, body)
        @client.post("onboardings/#{type}", body)
      end

      def update(id)
        @client.get("onboardings/#{id}/resume")
      end
    end
  end
end
