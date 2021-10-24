# frozen_string_literal: true

module Wallets
  module Operations
    class CalculateOperationTax
      OPERATION_TOTAL_VALUE_TAX_THRESHOLD = 20_000
      TAX_PERCENTAGE_OVER_PROFIT = 0.2

      def self.call(**args)
        new.call(**args)
      end

      def call(operation:, profit: nil,
               total_value: nil,
               unit_value: nil,
               weighted_average_cost: nil)

        if should_tax?(profit, total_value, unit_value, weighted_average_cost, operation)
          tax_over_profit(profit)
        else
          0
        end
      end

      private

      def tax_over_profit(profit)
        profit * TAX_PERCENTAGE_OVER_PROFIT
      end

      def should_tax?(profit, total_value, unit_value, weighted_average_cost, operation)
        return false if operation == 'buy'

        total_value > OPERATION_TOTAL_VALUE_TAX_THRESHOLD &&
          unit_value > weighted_average_cost &&
          profit.positive?
      end
    end
  end
end
