require_relative 'client/conn'
require_relative 'client/connection'
require_relative 'client/provider'
require_relative 'client/customer'
require_relative 'client/account'
require_relative 'client/transaction'

module SaltEdge
  class Client
    include HTTParty
    include Singleton
    include SaltEdge::Client::Conn
    include SaltEdge::Client::Connection
    include SaltEdge::Client::Provider
    include SaltEdge::Client::Customer
    include SaltEdge::Client::Account
    include SaltEdge::Client::Transaction

    EXPIRATION_TIME = 60
    base_uri 'https://www.saltedge.com'
    format :json
    attr_accessor :country_code, :provider_code
    attre_reader :logger

    def configure(app_id = nil, secret = nil, country_code = nil, provider_code = nil, logger = nil)
      @logger = logger
      app_id ||= ENV['SALTEDGE_APP_ID']
      secret ||= ENV['SALTEDGE_SECRET']
      country_code ||= ENV['SALT_EDGE_COUNTRY_CODE']

      provider_code ||= ENV['SALT_EDGE_PROVIDER_CODE']

      @country_code = country_code
      @provider_code = provider_code
      headers = {
        'Accept' => 'application/json',
        'Content-type' => 'application/json',
        'App-Id' => app_id.to_s,
        'Secret' => secret.to_s
      }

      self.class.default_options.merge!(headers: headers)
    end
  end
end
