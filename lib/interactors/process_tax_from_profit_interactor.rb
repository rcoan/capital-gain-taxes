# frozen_string_literal: true

class ProcessTaxFromProfitInteractor
  def self.call(*args)
    new.call(*args)
  end

  def call(operations_json)
    parsed_operations = parse_operations(operations_json)
    wallet = Wallet.new(operations: parsed_operations)

    wallet = Wallets::ProcessOperationsTaxService.call(wallet)

    WalletPresenter.new(wallet).json_formatted_taxes
  rescue JSON::ParserError => e
    'Invalid json string'
  rescue StandardError => e
    e.message
  end

  private

  def parse_operations(operations_json)
    raise_invalid_input_error if operations_json.nil? || operations_json.empty?

    parsed_operations = JSON.parse(operations_json)

    raise_invalid_input_error if parsed_operations.nil? || parsed_operations.empty?

    parsed_operations
  end

  def raise_invalid_input_error
    raise StandardError, 'Operations cannot be null or a empty array'
  end
end
