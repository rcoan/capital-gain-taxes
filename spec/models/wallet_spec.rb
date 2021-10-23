# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Wallet do
  subject { described_class.new(operations: []) }

  describe '#initialize' do
    it 'initializes object with default weighted_average_cost' do
      expect(subject.weighted_average_cost).to eq(0)
    end

    it 'initializes object with default total_profit' do
      expect(subject.total_profit).to eq(0)
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

    context 'when updating only total_profit' do
      it 'updates the desired field and does not change others' do
        subject.update(total_profit: 10)
        expect(subject.total_profit).to eq(10)
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
        subject.update(total_profit: 30)

        expect(subject.weighted_average_cost).to eq(10)
        expect(subject.total_stocks).to eq(20)
        expect(subject.total_profit).to eq(30)
      end
    end
  end
end
