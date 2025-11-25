# frozen_string_literal: true

module LemonwayOnboarding
  module Exceptions
    # All errors raised in LemonwayOnboarding should inherit from Error
    class Error < StandardError; end

    # Exception raised when a request was not successful
    class RequestError < Error
      attr_reader :code, :body

      # Initialize a request error. Contains response details.
      #
      # @param message [String] The error message that is displayed
      # @param code [Integer] The HTTP response status code
      # @param body [String] The content of the response
      # @return [LemonwayOnboarding::Exceptions::RequestError] An instance of RequestError
      def initialize(message, code:, body:)
        @code = code
        @body = body
        super(message)
      end
    end
  end
end
