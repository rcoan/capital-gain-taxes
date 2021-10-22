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
          weighted_average: wallet.total_profit
        }

        if operation['operation'] == 'buy'
          result = Operations::ProcessBuyService.call(operation_values)
          update_wallet(wallet, result)
        elsif operation['operation'] == 'sell'
        end
      end
      binding.pry

      wallet
    end

    private

    def update_wallet(wallet, new_attributes)
      wallet.update(new_attributes)
    end
  end
end
