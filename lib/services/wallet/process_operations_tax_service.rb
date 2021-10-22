module Wallets
  class ProcessOperationsTaxService
    def self.call(*args)
      new.call(*args)
    end

    def call(wallet)
      wallet.operations.each do |operation|
        operation_values = {
          unit_cost: operation['unit-cost'],
          quantity: operation['quantity'],
          total_stocks: wallet.total_stocks,
          weighted_average: wallet.weighted_average
        }

        result =
          case operation['operation']
          when 'buy'
            Operations::ProcessBuyService.call(operation_values)
          when 'sell'
            Operations::ProcessSellService.call(operation_values.merge(total_profit: wallet.total_profit))
          end

        update_wallet(wallet, result)
      end
      binding.pry

      wallet.taxes
    end

    private

    def update_wallet(wallet, new_attributes)
      wallet.update(new_attributes)
    end
  end
end
