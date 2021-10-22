module Wallets
  module Operations
    class ProcessBuyService
      def self.call(**args)
        new.call(**args)
      end

      def call(
        unit_cost:,
        quantity:,
        total_stocks:,
        weighted_average_cost:
      )


      new_total_stocks = total_stocks + quantity
      current_operation_total_value = unit_cost * quantity
      total_expent_previously = total_stocks * weighted_average_cost

      new_weighted_average = (total_expent_previously + current_operation_total_value)/new_total_stocks

      {
        total_stocks: new_total_stocks,
        weighted_average_cost: new_weighted_average
      }
      end
    end
  end
end

