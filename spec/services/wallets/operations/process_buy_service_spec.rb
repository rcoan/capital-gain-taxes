# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Wallets::Operations::ProcessBuyService do
  describe '#call' do
    context 'when total_stocks is zero' do
      context 'when weighted_average_cost is zero' do
        context 'when quantity is zero' do
          it 'raise error due buy operation zeroed quantity' do
            params = { unit_cost: 0, quantity: 0, total_stocks: 0, weighted_average_cost: 0 }

            expect { described_class.call(params) }
              .to raise_error(Wallets::Operations::ProcessBuyService::InvalidBuyQuantityError)
          end
        end

        context 'when quantity is a positive number' do
          context 'when unit_cost is zero' do
            it 'returns the expectec hash with weighted_average_cost zero' do
              params = { unit_cost: 0, quantity: 10, total_stocks: 0, weighted_average_cost: 0 }

              expected_response = { operation_tax: 0, total_stocks: 10, weighted_average_cost: 0 }

              expect(described_class.call(params)).to eq(expected_response)
            end
          end

          context 'when unit_cost is a positive number' do
            it 'returns the expectec hash with weighted_average_cost equal to unit_cost' do
              params = { unit_cost: 10, quantity: 15, total_stocks: 0, weighted_average_cost: 0 }

              expected_response = { operation_tax: 0, total_stocks: 15, weighted_average_cost: 10 }

              expect(described_class.call(params)).to eq(expected_response)
            end
          end
        end
      end

      context 'when weighted_average_cost is a positive number' do
        it 'returns the expected hash with the weighted_average_cost  equal to unit_cost ' do
          params = { unit_cost: 10, quantity: 15, total_stocks: 0, weighted_average_cost: 15 }

          expected_response = { operation_tax: 0, total_stocks: 15, weighted_average_cost: 10 }

          expect(described_class.call(params)).to eq(expected_response)
        end
      end
    end

    context 'when total_stocks is a positive number' do
      context 'when weighted_average_cost is zero' do
        context 'when quantity is zero' do
          it 'raise error due buy operation zeroed quantity' do
            params = { unit_cost: 0, quantity: 0, total_stocks: 10, weighted_average_cost: 0 }

            expect { described_class.call(params) }
              .to raise_error(Wallets::Operations::ProcessBuyService::InvalidBuyQuantityError)
          end

          it 'returns the hash with the expected hash' do
            params = { unit_cost: 0, quantity: 0, total_stocks: 10, weighted_average_cost: 0 }

            expected_response = { operation_tax: 0, total_stocks: 10, weighted_average_cost: 0 }

            expect { described_class.call(params) }
              .to raise_error(Wallets::Operations::ProcessBuyService::InvalidBuyQuantityError)
          end
        end

        context 'when quantity is a positive number' do
          context 'when unit_cost is zero' do
            it 'returns the expectec hash with total_stocks as the sum of the previous and new' do
              params = { unit_cost: 0, quantity: 10, total_stocks: 10, weighted_average_cost: 0 }

              expected_response = { operation_tax: 0, total_stocks: 20, weighted_average_cost: 0 }

              expect(described_class.call(params)).to eq(expected_response)
            end
          end

          context 'when unit_cost is a positive number' do
            it 'returns the expectec hash with weighted_average_cost different from unit_cost' do
              params = { unit_cost: 10, quantity: 15, total_stocks: 10, weighted_average_cost: 0 }

              expected_response = { operation_tax: 0, total_stocks: 25, weighted_average_cost: 6 }

              expect(described_class.call(params)).to eq(expected_response)
            end
          end
        end
      end

      context 'when weighted_average_cost is a positive number' do
        it 'returns the expected hash with the weighted_average_cost  equal to unit_cost ' do
          params = { unit_cost: 10, quantity: 15, total_stocks: 11, weighted_average_cost: 15 }

          expected_response = {
            operation_tax: 0,
            total_stocks: 26,
            weighted_average_cost: 12.115384615384615
          }

          expect(described_class.call(params)).to eq(expected_response)
        end
      end
    end
  end
end
