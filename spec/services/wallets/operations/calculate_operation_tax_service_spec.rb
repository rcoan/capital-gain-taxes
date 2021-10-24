# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Wallets::Operations::CalculateOperationTax do
  describe '#call' do
    subject { described_class.call(input) }

    let(:input) do
      {
        profit: profit,
        total_value: total_value,
        unit_value: unit_value,
        weighted_average_cost: weighted_average_cost,
        operation: operation
      }
    end

    context 'when operation sell' do
      context 'when Total above 20_000' do
        context 'when unit cost above average cost' do
          context 'when profit is positive' do
            let(:operation) { 'sell' }
            let(:total_value) { 20_001 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 25 }
            let(:profit) { 1000 }

            it 'returns the tax as 20% of profit' do
              expect(subject).to eq(200)
            end
          end

          context 'when profit is NOT positive' do
            let(:operation) { 'sell' }
            let(:total_value) { 20_001 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 25 }
            let(:profit) { -100 }

            it 'returns the tax as 0 since there was loss' do
              expect(subject).to eq(0)
            end
          end
        end

        context 'when unit cost NOT above average cost' do
          context 'when profit is positive' do
            let(:operation) { 'sell' }
            let(:total_value) { 20_001 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 10 }
            let(:profit) { 1000 }

            it 'returns the tax as 0 since the sell value was below average' do
              expect(subject).to eq(0)
            end
          end

          context 'when profit is NOT positive' do
            let(:operation) { 'sell' }
            let(:total_value) { 20_001 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 10 }
            let(:profit) { -100 }

            it 'returns the tax as 0 since the sell value was below average and there was loss' do
              expect(subject).to eq(0)
            end
          end
        end
      end

      context 'when Total NOT above 20_000' do
        context 'when unit cost above average cost' do
          context 'when profit is positive' do
            let(:operation) { 'sell' }
            let(:total_value) { 19_999 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 25 }
            let(:profit) { 1000 }

            it 'returns the tax as 0 since the total value was not above 20_000' do
              expect(subject).to eq(0)
            end
          end

          context 'when profit is NOT positive' do
            let(:operation) { 'sell' }
            let(:total_value) { 19_999 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 25 }
            let(:profit) { -100 }

            it 'returns the tax as 0 since the total value was not above 20_000 and \
              there was loss' do
              expect(subject).to eq(0)
            end
          end
        end

        context 'when unit cost NOT above average cost' do
          context 'when profit is positive' do
            let(:operation) { 'sell' }
            let(:total_value) { 19_999 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 10 }
            let(:profit) { 1000 }

            it 'returns the tax as 0 since the total value was not above 20_000 and \
              cost was below average cost' do
              expect(subject).to eq(0)
            end
          end

          context 'when profit is NOT positive' do
            let(:operation) { 'sell' }
            let(:total_value) { 19_999 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 10 }
            let(:profit) { -100 }

            it 'returns the tax as 0 since the total value was not above 20_000 and \
              cost was below average cost and there was loss' do
              expect(subject).to eq(0)
            end
          end
        end
      end
    end

    context 'when operation buy' do
      context 'when Total above 20_000' do
        context 'when unit cost above average cost' do
          context 'when profit is positive' do
            let(:operation) { 'buy' }
            let(:total_value) { 20_001 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 25 }
            let(:profit) { 1000 }

            it 'returns the tax as zero' do
              expect(subject).to eq(0)
            end
          end

          context 'when profit is NOT positive' do
            let(:operation) { 'buy' }
            let(:total_value) { 20_001 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 25 }
            let(:profit) { -100 }

            it 'returns the tax as zero' do
              expect(subject).to eq(0)
            end
          end
        end

        context 'when unit cost NOT above average cost' do
          context 'when profit is positive' do
            let(:operation) { 'buy' }
            let(:total_value) { 20_001 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 10 }
            let(:profit) { 1000 }

            it 'returns the tax as zero' do
              expect(subject).to eq(0)
            end
          end

          context 'when profit is NOT positive' do
            let(:operation) { 'buy' }
            let(:total_value) { 20_001 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 10 }
            let(:profit) { -100 }

            it 'returns the tax as zero' do
              expect(subject).to eq(0)
            end
          end
        end
      end

      context 'when Total NOT above 20_000' do
        context 'when unit cost above average cost' do
          context 'when profit is positive' do
            let(:operation) { 'buy' }
            let(:total_value) { 19_999 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 25 }
            let(:profit) { 1000 }

            it 'returns the tax as zero' do
              expect(subject).to eq(0)
            end
          end

          context 'when profit is NOT positive' do
            let(:operation) { 'buy' }
            let(:total_value) { 19_999 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 25 }
            let(:profit) { -100 }

            it 'returns the tax as zero' do
              expect(subject).to eq(0)
            end
          end
        end

        context 'when unit cost NOT above average cost' do
          context 'when profit is positive' do
            let(:operation) { 'buy' }
            let(:total_value) { 19_999 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 10 }
            let(:profit) { 1000 }

            it 'returns the tax as zero' do
              expect(subject).to eq(0)
            end
          end

          context 'when profit is NOT positive' do
            let(:operation) { 'buy' }
            let(:total_value) { 19_999 }
            let(:weighted_average_cost) { 15 }
            let(:unit_value) { 10 }
            let(:profit) { -100 }

            it 'returns the tax as zero' do
              expect(subject).to eq(0)
            end
          end
        end
      end
    end
  end
end
