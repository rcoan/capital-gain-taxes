# frozen_string_literal: true

module Wallets
  module Operations
    class ProcessBuyService
      def self.call(**args)
        new.call(**args)
      end

      def call(unit_cost:,
               quantity:,
               total_stocks:,
               weighted_average_cost:)

        @new_total_stocks = total_stocks + quantity
        @current_operation_total_value = unit_cost * quantity
        @total_expended_previously = total_stocks * weighted_average_cost

        format_response(new_total_stocks, new_weighted_average)
      end

      private

      def new_weighted_average
        total_expended = @total_expended_previously + @current_operation_total_value

        total_expended / @new_total_stocks
      end

      def format_response(total_stocks, weighted_average_cost)
        {
          total_stocks: total_stocks,
          weighted_average_cost: weighted_average_cost
        }
      end
    end
  end
end
