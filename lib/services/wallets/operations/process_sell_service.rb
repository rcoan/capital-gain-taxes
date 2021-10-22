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

        operation_total_value = unit_cost * quantity
        operation_profit = (unit_cost - weighted_average_cost) * quantity
        operation_profit_after_losses = calc_profit(total_profit, operation_profit)

        operation_tax = calc_operation_tax(
          operation_profit_after_losses,
          operation_total_value,
          unit_cost,
          weighted_average_cost,
        )

        new_total_stocks = total_stocks - quantity
        new_total_profit = operation_profit_after_losses

        format_response(operation_tax, new_total_stocks, new_total_profit)
      end

      private

      def calc_profit(total_profit, operation_profit)
        return operation_profit if total_profit.positive?

        operation_profit + total_profit
      end

      def calc_operation_tax(profit, operation_total_value, unit_cost, weighted_average_cost)
        if should_tax?(operation_total_value, unit_cost, weighted_average_cost, profit)
          profit * 0.2
        else
          0
        end
      end

      def should_tax?(operation_total_value,
                      unit_cost,
                      weighted_average_cost,
                      operation_profit_after_losses)
        operation_total_value > OPERATION_TOTAL_VALUE_TAX_THRESHOLD &&
          unit_cost > weighted_average_cost &&
          operation_profit_after_losses.positive?
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
