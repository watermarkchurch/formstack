require 'forwardable'

module Formstack
  module Model

    def self.included(base)
      base.send :attr_reader, :attributes
      base.extend ClassMethods
      base.extend Forwardable
      base.def_delegators :'self.class', :client, :client_method, :new_from_response
    end

    def initialize(attributes={})
      @attributes = attributes
    end

    def [](key)
      attributes[key.to_s]
    end

    def load
      @attributes = client.public_send(client_method, self[:id])
    end

    def update(new_attributes={})
      attributes.merge!(stringify_hash_keys(new_attributes))
      client.public_send("update_#{client_method}", self[:id], attributes)
    end

    def delete
      client.public_send("delete_#{client_method}", self[:id])
    end

    private

    def stringify_hash_keys(hash)
      hash.each_with_object({}) { |(k, v), h| h[k.to_s] = v }
    end

    module ClassMethods

      def all(*args)
        new_from_response client.public_send("#{client_method}s", *args)
      end

      def find(*args)
        new_from_response client.public_send(client_method, *args)
      end

      def create(*args)
        new_from_response(client.public_send("create_#{client_method}", *args)).tap do |obj|
          obj.load
        end
      end

      def new_from_response(response)
        if response.respond_to?(:has_key?) && response.has_key?(response_nesting)
          response = response[response_nesting]
        end
        if response.is_a?(Array)
          response.map { |item| new item }
        else
          new response
        end
      end

      def client
        Formstack.client
      end

      def client_method
        raise NotImplementedError
      end

      def response_nesting
        ""
      end

    end
  end
end
