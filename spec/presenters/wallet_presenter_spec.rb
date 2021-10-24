# frozen_string_literal: true

require 'spec_helper'

RSpec.describe WalletPresenter do
  subject { described_class.new(wallet) }

  let(:wallet) { Wallet.new(operations: []) }

  describe '#to_json' do
    context 'when no taxes were added' do
      it 'returns an empty array as json' do
        expect(subject.to_json).to eq([].to_json)
      end
    end

    context 'when taxes were added' do
      it 'returns an array with format multiple {tax: tax_value} as json' do
        wallet.update(operation_tax: 10)
        wallet.update(operation_tax: 15)
        wallet.update(operation_tax: 5)

        expected_result = [{ tax: 10 }, { tax: 15 }, { tax: 5 }].to_json

        expect(subject.to_json).to eq(expected_result)
      end
    end
  end
end
