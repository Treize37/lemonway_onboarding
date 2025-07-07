# frozen_string_literal: true

module LemonwayOnboarding
  # Configuration of the LemonwayOnboarding API client gem.
  class Configuration
    attr_accessor :base_url, :environment, :logger, :proxy, :timeout, :token, :version

    # Initializes the configuration with default values.
    # You can pass a block to configure the instance.
    #
    # @yield [self] Optional block to configure the instance
    # @return [LemonwayOnboarding::Configuration] The configured instance
    def initialize
      @environment = ENV['LEMONWAY_ONBOARDING_ENV'] || 'production'
      @version = 'v1'
      @timeout = 30
      @token = nil
      @proxy = nil
      @logger = Logger.new($stdout)

      yield self if block_given?

      base_url_from_env
    end

    # Configures the instance with a block.
    #
    # @yield [self] Block to configure the instance
    # @return [void]
    def configure
      yield(self) if block_given?
    end

    # Validates the configuration values.
    #
    # @return [void]
    # @raise [RuntimeError] If required attributes are missing or invalid
    def validate!
      error_on('token') unless @token
      error_on('environment') unless %[sandbox production].include?(@environment)
    end

    private

    # Private: Sets the base URL based on the environment.
    #
    # @return [void]
    def base_url_from_env
      @base_url = case @environment
                  when 'production'
                    'https://onboarding-api.lemonway.com'
                  when 'sandbox'
                    'https://onboarding-api.sandbox.lemonway.com'
                  end
    end

    # Private: Raises an error if a required attribute is missing.
    #
    # @param attribute [String] The name of the missing attribute
    # @raise [RuntimeError] If the attribute is missing
    def error_on(attribute)
      raise(
        "#{attribute} is missing. " \
          "Please configure LemonwayOnboarding::Configuration.#{attribute}."
      )
    end
  end
end
