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

        current_operation_total_value = unit_cost * quantity

        current_operation_profit = (unit_cost - weighted_average_cost) * quantity

        current_operation_profit_after_losses = total_profit.negative? ? current_operation_profit + total_profit : current_operation_profit

        # transform rules in validators
        should_tax =
          current_operation_total_value > OPERATION_TOTAL_VALUE_TAX_THRESHOLD &&
          unit_cost > weighted_average_cost &&
          current_operation_profit_after_losses.positive?

        operation_tax = should_tax ? current_operation_profit_after_losses * 0.2 : 0.0
        new_total_stocks = total_stocks - quantity
        new_total_profit = current_operation_profit_after_losses

        {
          operation_tax: operation_tax,
          total_stocks: new_total_stocks,
          total_profit: new_total_profit
        }
      end
    end
  end
end
