# frozen_string_literal: true

module Wallets
  module Operations
    class ProcessBuyService
      class InvalidBuyQuantityError < StandardError;  end

      def self.call(**args)
        new.call(**args)
      end

      def call(unit_cost:,
               quantity:,
               total_stocks:,
               weighted_average_cost:)

        if quantity.zero? || quantity.negative?
          raise InvalidBuyQuantityError.new('Invalid quantity for buy operation')
        end

        new_total_stocks = total_stocks.to_f + quantity
        operation_total_value = unit_cost.to_f * quantity
        total_expended_previously = total_stocks * weighted_average_cost

        new_weighted_average = calc_new_weighted_average(
          new_total_stocks,
          operation_total_value,
          total_expended_previously
        )

        format_response(new_total_stocks, new_weighted_average)
      end

      private

      def calc_new_weighted_average(new_total_stocks,
                                    operation_total_value,
                                    total_expended_previously)
        total_expended = total_expended_previously + operation_total_value

        total_expended / new_total_stocks
      end

      def format_response(total_stocks, weighted_average_cost)
        {
          operation_tax: 0,
          total_stocks: total_stocks,
          weighted_average_cost: weighted_average_cost
        }
      end
    end
  end
end
