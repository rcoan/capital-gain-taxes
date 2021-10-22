module Wallets
  module Operations
    class ProcessSellService
      def self.call(**args)
        new.call(**args)
      end

      def call(
        unit_cost:,
        quantity:,
        total_stocks:,
        weighted_average:,
        total_profit:
      )
      {}
      end


    end
  end
end
