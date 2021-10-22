# frozen_string_literal: true

class ProcessTaxFromProfitInteractor
  def self.call(*args)
    new.call(*args)
  end

  def call(operations_json)
    parsed_operations = JSON.parse(operations_json)
    wallet = Wallet.new(operations: parsed_operations)

    wallet = Wallets::ProcessOperationsTaxService.call(wallet)

    WalletPresenter.new(wallet).json_formatted_taxes
  end
end
