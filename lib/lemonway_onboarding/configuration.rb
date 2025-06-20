# frozen_string_literal: true

module LemonwayOnboarding
  # Configuration of the LemonwayOnboarding API client gem.
  class Configuration
    attr_accessor :base_url, :token, :version, :environment, :proxy, :timeout

    # Initializes the configuration with default values.
    def initialize
      @environment = ENV['LEMONWAY_ONBOARDING_ENV'] || 'production'
      @version = 'v1'
      @timeout = 30
      @token = nil
      @proxy = nil

      yield self if block_given?

      base_url_from_env
    end

    def configure
      yield(self) if block_given?
    end

    # Validates the configuration values.
    def validate!
      error_on('token') unless @token
      error_on('environment') unless %[sandbox production].include?(@environment)
    end

    private

    def base_url_from_env
      @base_url = case @environment
                  when 'production'
                    'https://onboarding-api.lemonway.com'
                  when 'sandbox'
                    'https://onboarding-api.sandbox.lemonway.com'
                  end
    end

    def error_on(attribute)
      raise(
        "#{attribute} is missing. " \
          "Please configure LemonwayOnboarding::Configuration.#{attribute}."
      )
    end
  end
end
