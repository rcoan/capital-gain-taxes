# frozen_string_literal: true

class ProcessTaxFromProfitInteractor
  def self.call(*args)
    new.call(*args)
  end

  def call(operations_json)
    operations_list = Wallets::Operations::BuildOperationsFromJsonService.call(operations_json)

    wallet = Wallet.new(operations: operations_list)

    return format_response(wallet.errors) unless wallet.valid?

    wallet = Wallets::ProcessOperationsTaxService.call(wallet)

    format_response(WalletPresenter.new(wallet))
  rescue StandardError => e
    e.message
  end

  private

  def format_response(response)
    response.to_json
  end
end
