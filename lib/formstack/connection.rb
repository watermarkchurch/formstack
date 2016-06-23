require 'net/http'
require 'uri'
require 'json'

module Formstack
  class Connection
    attr_reader :base_uri, :access_token

    BASE_URI = URI('https://www.formstack.com/api/v2/').freeze

    def initialize(base_uri: BASE_URI, access_token: ENV['FORMSTACK_ACCESS_TOKEN'])
      @base_uri = URI(base_uri)
      @access_token = access_token
    end

    def get(uri, args={})
      request(uri: uri, request_factory: Net::HTTP::Get, args: args)
    end

    def post(uri, args={})
      request(uri: uri, request_factory: Net::HTTP::Post, args: args)
    end

    def put(uri, args={})
      request(uri: uri, request_factory: Net::HTTP::Put, args: args)
    end

    def delete(uri, args={})
      request(uri: uri, request_factory: Net::HTTP::Delete, args: args)
    end

    private

    def request(uri:, request_factory:, args: {})
      uri = base_uri + uri
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        request = request_factory.new uri
        request["Authorization"] = "Bearer #{access_token}"
        if !args.empty?
          request["Content-Type"] = "application/json"
          request.body = args.to_json
        end
        http.request request
      end

      parse_response(response)
    end

    def parse_response(response)
      JSON.parse(response.body)
    end
  end
end
