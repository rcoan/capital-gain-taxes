# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Wallets::Operations::ProcessSellService do
  describe '#call' do
    subject { described_class.call(input) }

    before do
      allow(Wallets::Operations::CalculateOperationTax).to receive(:call).and_return(tax)
    end

    context 'when previous operations had no loss' do
      context 'when sell has profit' do
        let(:tax) { 10 }
        let(:input) do
          {
            unit_cost: 10,
            quantity: 10,
            total_stocks: 10,
            weighted_average_cost: 5,
            total_loss: 0
          }
        end

        it 'returns total profit of current operation' do
          expected_result = { operation_tax: tax, total_stocks: 0, total_loss: 0 }

          expect(subject).to eq(expected_result)
        end
      end

      context 'when sell has loss' do
        let(:tax) { 0 }
        let(:input) do
          {
            unit_cost: 10,
            quantity: 10,
            total_stocks: 10,
            weighted_average_cost: 15,
            total_loss: 0
          }
        end

        it 'returns total profit less then it was before' do
          expected_result = { operation_tax: tax, total_stocks: 0, total_loss: 50 }

          expect(subject).to eq(expected_result)
        end
      end

      context 'when sell has no loss or profit' do
        let(:tax) { 0 }
        let(:input) do
          {
            unit_cost: 10,
            quantity: 10,
            total_stocks: 10,
            weighted_average_cost: 10,
            total_loss: 0
          }
        end

        it 'returns total profit zeroed' do
          expected_result = { operation_tax: tax, total_stocks: 0, total_loss: 0 }

          expect(subject).to eq(expected_result)
        end
      end
    end

    context 'when previous operations had loss' do
      let(:tax) { 0 }

      context 'when sell has profit' do
        let(:input) do
          {
            unit_cost: 10,
            quantity: 10,
            total_stocks: 10,
            weighted_average_cost: 5,
            total_loss: 100
          }
        end

        it 'returns total profit of current operation' do
          expected_result = { operation_tax: tax, total_stocks: 0, total_loss: 50 }

          expect(subject).to eq(expected_result)
        end
      end

      context 'when sell has loss' do
        let(:input) do
          {
            unit_cost: 10,
            quantity: 10,
            total_stocks: 10,
            weighted_average_cost: 15,
            total_loss: 100
          }
        end

        it 'returns total profit less then it was before' do
          expected_result = { operation_tax: tax, total_stocks: 0, total_loss: 150 }

          expect(subject).to eq(expected_result)
        end
      end

      context 'when sell has no loss or profit' do
        let(:input) do
          {
            unit_cost: 10,
            quantity: 10,
            total_stocks: 10,
            weighted_average_cost: 10,
            total_loss: 100
          }
        end

        it 'returns total profit equal as before' do
          expected_result = { operation_tax: tax, total_stocks: 0, total_loss: 100 }

          expect(subject).to eq(expected_result)
        end
      end
    end
  end
end
