# frozen_string_literal: true

require 'typhoeus'
require_relative 'configuration'

module LemonwayOnboarding
  # Client for interacting with the Ohme API
  class Client
    # Initializes the client with the configuration
    def initialize(configuration = LemonwayOnboarding::Configuration.new)
      @configuration = configuration
      @configuration.validate!
    end

    # Performs a GET request
    def get(endpoint, params = {})
      request(:get, endpoint, params: params)
    end

    # Performs a POST request
    def post(endpoint, body = {})
      request(:post, endpoint, body: body)
    end

    # Performs a PUT request
    def put(endpoint, body = {})
      request(:put, endpoint, body: body)
    end

    # Performs a DELETE request
    def delete(endpoint, params = {})
      request(:delete, endpoint, params: params)
    end

    private

    # Private: Performs an HTTP request
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

    def log_request(method, endpoint, options)
      @configuration.logger.info("Request: #{method.upcase} #{build_url(endpoint)}")
      @configuration.logger.debug("Headers: #{build_headers}")
      @configuration.logger.debug("Params: #{options[:params]}") if options[:params]
      @configuration.logger.debug("Body: #{options[:body]}") if options[:body]
    end

    def build_url(endpoint)
      "#{@configuration.base_url}/#{endpoint}"
    end

    # Builds the headers for the request
    def build_headers
      {
        'Authorization' => "Bearer #{@configuration.token}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    end

    # Handle the API response
    def handle_response(response)
      log_response(response)

      if response.timed_out?
        raise 'Request timed out. Please check your network connection or increase the timeout.'
      elsif response.success?
        # Return nil for DELETE requests with no body
        return nil if response.body.nil? || response.body.strip.empty?

        # Parse JSON for other successful responses
        JSON.parse(response.body)
      else
        raise "HTTP request failed: #{response.code} - #{response.body}"
      end
    end

    def log_response(response)
      @configuration.logger.info("Response code: #{response.code}")
      @configuration.logger.debug("Response body: #{response.body}")
    end
  end
end
