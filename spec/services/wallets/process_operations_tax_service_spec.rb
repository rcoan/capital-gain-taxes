# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Wallets::ProcessOperationsTaxService do
  describe '#call' do
    it 'updates wallet after processing each operation and returns the same object' do
      buy_result = {
        operation_tax: 0,
        total_stocks: 10,
        weighted_average_cost: 10
      }

      sell_result = {
        operation_tax: 0,
        total_stocks: 0,
        total_loss: 0
      }

      buy_operation = Operation.new(type: 'buy', unit_value: 10, quantity: 10)
      sell_operation = Operation.new(type: 'sell', unit_value: 10, quantity: 10)
      operations = [buy_operation, sell_operation]

      wallet = Wallet.new(operations: operations)

      allow(wallet).to receive(:update).and_call_original

      expect(wallet).to receive(:update).with(buy_result).once
      expect(wallet).to receive(:update).with(sell_result).once

      expect(described_class.call(wallet)).to eq(wallet)
    end
  end
end
