module Wallets
  class ProcessOperationsTaxService
    def self.call(*args)
      new.call(*args)
    end

    def call(wallet)
      wallet.operations.each do |operation|
        result =
          case operation['operation']
          when 'buy'
            Operations::ProcessBuyService.call(filter_buy_operations_params(operation, wallet))
          when 'sell'
            Operations::ProcessSellService.call(filter_sell_operations_params(operation, wallet))
          end

        update_wallet(wallet, result)
      end

      wallet
    end

    private

    def filter_buy_operations_params(operation, wallet)
      {
        unit_cost: operation['unit-cost'],
        quantity: operation['quantity'],
        total_stocks: wallet.total_stocks,
        weighted_average_cost: wallet.weighted_average_cost
      }
    end


    def filter_sell_operations_params(operation, wallet)
      {
        unit_cost: operation['unit-cost'],
        quantity: operation['quantity'],
        total_stocks: wallet.total_stocks,
        weighted_average_cost: wallet.weighted_average_cost,
        total_profit: wallet.total_profit
      }
    end

    def update_wallet(wallet, new_attributes)
      wallet.update(new_attributes)
    end
  end
end
