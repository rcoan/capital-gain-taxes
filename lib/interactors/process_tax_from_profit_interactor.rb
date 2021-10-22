class ProcessTaxFromProfitInteractor
  def self.call(*args)
    new.call(*args)
  end

  def call(input_json)
    # vira um service de parser
    parsed_input = JSON.parse(input_json)
    wallet = Wallet.new(operations: parsed_input)

    wallet = Wallets::ProcessOperationsTaxService.call(wallet)

    WalletPressenter.new(wallet).json_formatted_taxes
  end
end
