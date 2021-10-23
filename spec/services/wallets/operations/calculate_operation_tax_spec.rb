# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Wallets::Operations::CalculateOperationTax do
  describe '#call' do
    subject { described_class.call(input) }

    let(:input) do
      {
        profit: profit,
        total_value: total_value,
        unit_cost: unit_cost,
        weighted_average_cost: weighted_average_cost,
        operation: operation
      }
    end

    context 'when operation buy' do
      context 'when Total above 20_000' do
        context 'when unit cost above average cost' do
          context 'when profit is positive' do
          end

          context 'when profit is NOT positive' do
          end
        end

        context 'when unit cost NOT above average cost' do
          context 'when profit is positive' do
          end

          context 'when profit is NOT positive' do
          end
        end
      end

      context 'when Total NOT above 20_000' do
        context 'when unit cost above average cost' do
          context 'when profit is positive' do
          end

          context 'when profit is NOT positive' do
          end
        end

        context 'when unit cost NOT above average cost' do
          context 'when profit is positive' do
          end

          context 'when profit is NOT positive' do
          end
        end
      end
    end

    context 'when operation sell' do
      context 'when Total above 20_000' do
        context 'when unit cost above average cost' do
          context 'when profit is positive' do
          end

          context 'when profit is NOT positive' do
          end
        end

        context 'when unit cost NOT above average cost' do
          context 'when profit is positive' do
          end

          context 'when profit is NOT positive' do
          end
        end
      end

      context 'when Total NOT above 20_000' do
        context 'when unit cost above average cost' do
          context 'when profit is positive' do
          end

          context 'when profit is NOT positive' do
          end
        end

        context 'when unit cost NOT above average cost' do
          context 'when profit is positive' do
          end

          context 'when profit is NOT positive' do
          end
        end
      end
    end
  end
end
