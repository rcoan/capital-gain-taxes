# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Wallet do
  describe '#initialize' do
    subject { described_class.new(operations: []) }

    it 'initializes object with default weighted_average_cost' do
      expect(subject.weighted_average_cost).to eq(0)
    end

    it 'initializes object with default total_loss' do
      expect(subject.total_loss).to eq(0)
    end

    it 'initializes object with default total_stocks' do
      expect(subject.total_stocks).to eq(0)
    end

    it 'initializes object with default taxes' do
      expect(subject.taxes).to eq([])
    end

    it 'initializes object with default operations' do
      expect(subject.operations).to eq([])
    end
  end

  describe '#update' do
    subject { described_class.new(operations: []) }

    context 'when updating only weighted_average_cost' do
      it 'updates the desired field and does not change others' do
        subject.update(weighted_average_cost: 10)
        expect(subject.weighted_average_cost).to eq(10)
      end
    end

    context 'when updating only total_stocks' do
      it 'updates the desired field and does not change others' do
        subject.update(total_stocks: 10)
        expect(subject.total_stocks).to eq(10)
      end
    end

    context 'when updating only total_loss' do
      it 'updates the desired field and does not change others' do
        subject.update(total_loss: 10)
        expect(subject.total_loss).to eq(10)
      end
    end

    context 'when updating only taxes' do
      it 'add a new entry to the desired field a array and does not change others' do
        subject.update(operation_tax: 10)
        subject.update(operation_tax: 20)
        expect(subject.taxes).to eq([10, 20])
      end
    end

    context 'when updating multiple fields' do
      it 'updates all the desired field and does not change others' do
        subject.update(weighted_average_cost: 10)
        subject.update(total_stocks: 20)
        subject.update(total_loss: 30)

        expect(subject.weighted_average_cost).to eq(10)
        expect(subject.total_stocks).to eq(20)
        expect(subject.total_loss).to eq(30)
      end
    end
  end

  describe '#valid?' do
    subject { described_class.new(operations: operations) }

    context 'when all operations are valid' do
      let(:buy_operation) { Operation.new(type: 'buy', unit_value: 10, quantity: 10) }
      let(:sell_operation) { Operation.new(type: 'sell', unit_value: 10, quantity: 10) }
      let(:operations) { [buy_operation, sell_operation] }

      it 'returns as valid' do
        expect(subject.valid?).to be(true)
      end

      it 'returns the errors attribute as an empty array' do
        subject.valid?
        expect(subject.errors).to eq([])
      end
    end

    context 'when there are invalid operations' do
      let(:buy_operation) { Operation.new(type: 'foo', unit_value: 10, quantity: 10) }
      let(:sell_operation) { Operation.new(type: 'sell', unit_value: -10, quantity: 10) }
      let(:operations) { [buy_operation, sell_operation] }


      it 'returns as valid' do
        expect(subject.valid?).to be(false)
      end

      it 'returns the errors attribute as an empty array' do
        subject.valid?
        expect(subject.errors).to eq(
          [
            ["The operation must be one of the following: [\"buy\", \"sell\"]"],
            ["The unit value of an operation must not be negative"]
          ]
        )
      end
    end
  end
end
