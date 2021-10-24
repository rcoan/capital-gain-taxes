# frozen_string_literal: true

module Wallets
  module Operations
    class BuildOperationsFromJsonService
      def self.call(*args)
        new.call(*args)
      end

      def call(operations_json)
        parsed_operations = parse_operations(operations_json)

        parsed_operations.map do |parsed_operation|
          Operation.new(
            type: parsed_operation['operation'],
            value: parsed_operation['unit-cost'],
            quantity: parsed_operation['quantity']
          )
        end
      end

      private

      def parse_operations(operations_json)
        raise_invalid_input_error if operations_json.nil? || operations_json.empty?
        JSON.parse(operations_json)

      rescue JSON::ParserError => e
        raise StandardError, 'Invalid json string'
      end

      def raise_invalid_input_error
        raise StandardError, 'Operations cannot be null or a empty array'
      end
    end
  end
end
