# frozen_string_literal: true

require 'typhoeus'
require_relative 'configuration'

module LemonwayOnboarding
  # Client for interacting with the Ohme API
  class Client
    # Initializes the client with the configuration
    #
    # @param configuration [LemonwayOnboarding::Configuration] The configuration object
    def initialize(configuration = LemonwayOnboarding::Configuration.new)
      @configuration = configuration
      @configuration.validate!
    end

    # Performs a GET request
    #
    # @param endpoint [String] The API endpoint to access
    # @param params [Hash] Optional parameters to include in the request
    # @return [Hash, nil] The parsed JSON response or nil for DELETE requests with
    def get(endpoint, params = {})
      request(:get, endpoint, params: params)
    end

    # Performs a POST request
    #
    # @param endpoint [String] The API endpoint to access
    # @param body [Hash] The body of the POST request
    # @return [Hash] The parsed JSON response
    def post(endpoint, body = {})
      request(:post, endpoint, body: body)
    end

    # Performs a PUT request
    #
    # @param endpoint [String] The API endpoint to access
    # @param body [Hash] The body of the PUT request
    # @return [Hash] The parsed JSON response
    def put(endpoint, body = {})
      request(:put, endpoint, body: body)
    end

    # Performs a DELETE request
    #
    # @param endpoint [String] The API endpoint to access
    # @param params [Hash] Optional parameters to include in the request
    # @return [Hash, nil] The parsed JSON response or nil for DELETE requests with
    #   no body
    def delete(endpoint, params = {})
      request(:delete, endpoint, params: params)
    end

    private

    # Private: Performs an HTTP request
    #
    # @param method [Symbol] The HTTP method (e.g., :get, :post, :put, :delete)
    # @param endpoint [String] The API endpoint to access
    # @param options [Hash] Additional options for the request (e.g., params,
    #   body)
    # @return [Hash, nil] The parsed JSON response or nil for DELETE requests with no body
    def request(method, endpoint, options = {})
      log_request(method, endpoint, options)

      response = Typhoeus::Request.new(
        build_url(endpoint),
        method: method,
        headers: build_headers,
        params: options[:params],
        body: options[:body]&.to_json,
        timeout: @configuration.timeout,
        proxy: @configuration.proxy
      ).run

      handle_response(response)
    end

    # Private: Logs the request details
    #
    # @param method [Symbol] The HTTP method (e.g., :get, :post)
    # @param endpoint [String] The API endpoint being accessed
    # @param options [Hash] Additional options for the request (e.g., params,
    #   body)
    # # @return [void]
    def log_request(method, endpoint, options)
      @configuration.logger.info("Request: #{method.upcase} #{build_url(endpoint)}")
      @configuration.logger.debug("Headers: #{build_headers}")
      @configuration.logger.debug("Params: #{options[:params]}") if options[:params]
      @configuration.logger.debug("Body: #{options[:body]}") if options[:body]
    end

    # Private: Builds the full URL for the API endpoint
    #
    # @param endpoint [String] The API endpoint to build the URL for
    # @return [String] The full URL for the API endpoint
    def build_url(endpoint)
      "#{@configuration.base_url}/#{endpoint}"
    end

    # Private: Builds the headers for the request
    #
    # @return [Hash] The headers for the request
    def build_headers
      {
        'Authorization' => "Bearer #{@configuration.token}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    end

    # Private: Handle the API response
    #
    # @param response [Typhoeus::Response] The response object from the HTTP request
    # @return [Hash, nil] The parsed JSON response or nil for DELETE requests with no body
    def handle_response(response)
      log_response(response)

      if response.timed_out?
        request_error('Request timed out. Please check your network connection or increase the timeout.', response)
      elsif response.success?
        # Return nil for DELETE requests with no body
        return nil if response.body.nil? || response.body.strip.empty?

        # Parse JSON for other successful responses
        JSON.parse(response.body)
      else
        request_error("HTTP request failed: #{response.code} - #{response.body}", response)
      end
    end

    # Private: Raise RequestError when a request was not successful
    #
    # @param message [String] The message that will be given to the exception
    # @param response [Typhoeus::Response] The response object from the HTTP request
    # @return [void] Raise an error
    def request_error(message, response)
      raise Exceptions::RequestError.new(message, code: response.code, body: response.body)
    end

    # Private: Logs the response details
    #
    # @param response [Typhoeus::Response] The response object from the HTTP request
    # @return [void]
    def log_response(response)
      @configuration.logger.info("Response code: #{response.code}")
      @configuration.logger.debug("Response body: #{response.body}")
    end
  end
end
