# frozen_string_literal: true

class ProcessTaxFromProfitInteractor
  def self.call(*args)
    new.call(*args)
  end

  def call(operations_json)
    operations_list = Wallets::Operations::BuildOperationsFromJsonService.call(operations_json)

    wallet = Wallet.new(operations: operations_list)

    return wallet.errors if wallet.invalid?

    wallet = Wallets::ProcessOperationsTaxService.call(wallet)

    WalletPresenter.new(wallet).json_formatted_taxes
  rescue StandardError => e
    e.message
  end
end
