# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Wallets::Operations::BuildOperationsFromJsonService do
  describe '#call' do
    subject { described_class.call(input) }

    context 'with a valid input' do
      let(:input) do
        [
          { operation: 'buy', 'unit-cost': 10, quantity: 100 },
          { operation: 'sell', 'unit-cost': 15, quantity: 50 }
        ].to_json
      end

      it 'returns an array with the operations' do
        buy_operation = Operation.new(type: 'buy', unit_value: 10, quantity: 100)
        sell_operation = Operation.new(type: 'sell', unit_value: 15, quantity: 50)

        result = subject
        expect(result.size).to eq(2)
        expect(result[0].type).to eq('buy')
        expect(result[0].unit_value).to eq(10)
        expect(result[0].quantity).to eq(100)

        expect(result[1].type).to eq('sell')
        expect(result[1].unit_value).to eq(15)
        expect(result[1].quantity).to eq(50)
      end
    end

    context 'with a empty string as input' do
      let(:input) do
        ''
      end

      it 'raises error' do
        expect {subject}.to raise_error(/Operations cannot be null or a empty array/)
      end
    end

    context 'with a invalid json as input' do
      let(:input) do
        'invalid'
      end

      it 'raises error' do
        expect {subject}.to raise_error(/Invalid json string/)
      end
    end

    context 'with a a valid json with empty hash' do
      let(:input) do
        '[{}, {}]'
      end

      it 'returns an array with the operations' do
        buy_operation = Operation.new(type: nil, unit_value: nil, quantity: nil)
        sell_operation = Operation.new(type: nil, unit_value: nil, quantity: nil)

        result = subject
        expect(result.size).to eq(2)
        expect(result[0].type).to eq(nil)
        expect(result[0].unit_value).to eq(nil)
        expect(result[0].quantity).to eq(nil)

        expect(result[1].type).to eq(nil)
        expect(result[1].unit_value).to eq(nil)
        expect(result[1].quantity).to eq(nil)
      end
    end
  end
end
