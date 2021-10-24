# frozen_string_literal: true

module Wallets
  module Operations
    class ProcessSellService
      OPERATION_TOTAL_VALUE_TAX_THRESHOLD = 20_000

      def self.call(**args)
        new.call(**args)
      end

      def call(unit_value:,
               quantity:,
               total_stocks:,
               weighted_average_cost:,
               total_loss:)

        new_total_stocks = total_stocks - quantity
        operation_total_value = unit_value * quantity

        operation_profit = calc_profit(total_loss, unit_value, weighted_average_cost, quantity)

        operation_tax = CalculateOperationTax.call(
          profit: operation_profit,
          total_value: operation_total_value,
          unit_value: unit_value,
          weighted_average_cost: weighted_average_cost,
          operation: 'sell'
        )

        current_loss = operation_profit.negative? ? operation_profit.abs : 0

        format_response(operation_tax, new_total_stocks, current_loss)
      end

      private

      def calc_profit(total_loss, unit_value, weighted_average_cost, quantity)
        operation_profit = (unit_value - weighted_average_cost) * quantity
        return operation_profit - total_loss if total_loss.positive?

        operation_profit
      end

      def format_response(operation_tax, total_stocks, current_loss)
        {
          operation_tax: operation_tax,
          total_stocks: total_stocks,
          total_loss: current_loss
        }
      end
    end
  end
end
