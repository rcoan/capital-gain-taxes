# frozen_string_literal: true

module Wallets
  module Operations
    class ProcessSellService
      OPERATION_TOTAL_VALUE_TAX_THRESHOLD = 20_000

      def self.call(**args)
        new.call(**args)
      end

      def call(unit_cost:,
               quantity:,
               total_stocks:,
               weighted_average_cost:,
               total_profit:)

        new_total_stocks = total_stocks - quantity
        operation_total_value = unit_cost * quantity

        operation_profit = calc_profit(
          total_profit,
          unit_cost,
          weighted_average_cost,
          quantity
        )

        operation_tax = CalculateOperationtax.call(
          profit: operation_profit,
          total_value: operation_total_value,
          unit_cost: unit_cost,
          weighted_average_cost: weighted_average_cost,
          operation: 'sell'
        )

        format_response(operation_tax, new_total_stocks, operation_profit)
      end

      private

      def calc_profit(total_profit, unit_cost, weighted_average_cost, quantity)
        operation_profit = (unit_cost - weighted_average_cost) * quantity
        return operation_profit if total_profit.positive?

        operation_profit + total_profit
      end

      def format_response(operation_tax, total_stocks, total_profit)
        {
          operation_tax: operation_tax,
          total_stocks: total_stocks,
          total_profit: total_profit
        }
      end
    end
  end
end
