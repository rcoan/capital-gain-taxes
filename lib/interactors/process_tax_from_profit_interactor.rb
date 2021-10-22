class ProcessTaxFromProfitInteractor
  def self.call(*args)
    new.call(*args)
  end

  def call(input_json)
    # vira um service de parser
    parsed_input = JSON.parse(input_json)
    wallet = Wallet.new(operations: parsed_input)

    taxes = Wallets::ProcessOperationsTaxService.call(wallet)

    # vira um service de presenter
    taxes.to_json
  end
end
