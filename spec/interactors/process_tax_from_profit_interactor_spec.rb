# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ProcessTaxFromProfitInteractor, 'Calculate taxes' do
  subject { ProcessTaxFromProfitInteractor.call(input) }

  context 'With exemple cases from test' do
    context 'with First input exemple' do
      let(:input) do
        [
          { operation: 'buy', 'unit-cost': 10, quantity: 100 },
          { operation: 'sell', 'unit-cost': 15, quantity: 50 },
          { operation: 'sell', 'unit-cost': 15, quantity: 50 }
        ].to_json
      end

      let(:expected_response) do
        [{ tax: 0 }, { tax: 0 }, { tax: 0 }].to_json
      end

      it 'returns all taxes as zero' do
        expect(subject).to  eq(expected_response)
      end
    end

    context 'with Second input exemple' do
      let(:input) do
        [
          { operation: 'buy', 'unit-cost': 10, quantity: 10_000 },
          { operation: 'sell', 'unit-cost': 20, quantity: 5_000 },
          { operation: 'sell', 'unit-cost': 5, quantity: 5_000 }
        ].to_json
      end

      let(:expected_response) do
        [{ tax: 0 }, { tax: 10_000.0 }, { tax: 0 }].to_json
      end

      it 'returns the first tax as 10_000 and the secon zero' do
        expect(subject).to  eq(expected_response)
      end
    end

    context 'with Third input exemple' do
      let(:input) do
        [
          { operation: 'buy', 'unit-cost': 10, quantity: 10_000 },
          { operation: 'sell', 'unit-cost': 5, quantity: 5_000 },
          { operation: 'sell', 'unit-cost': 20, quantity: 5_000 }
        ].to_json
      end

      let(:expected_response) do
        [{ tax: 0 }, { tax: 0 }, { tax: 5_000.0 }].to_json
      end

      it 'returns the first tax as zero and the second as 5_000' do
        expect(subject).to  eq(expected_response)
      end
    end

    context 'with Fourth input exemple' do
      let(:input) do
        [
          { operation: 'buy', 'unit-cost': 10, quantity: 10_000 },
          { operation: 'buy', 'unit-cost': 25, quantity: 5_000 },
          { operation: 'sell', 'unit-cost': 15, quantity: 10_000 }
        ].to_json
      end

      let(:expected_response) do
        [{ tax: 0 }, { tax: 0 }, { tax: 0 }].to_json
      end

      it 'returns the only sell tax as zero' do
        expect(subject).to  eq(expected_response)
      end
    end

    context 'with Fifth input exemple' do
      let(:input) do
        [
          { operation: 'buy', 'unit-cost': 10, quantity: 10_000 },
          { operation: 'buy', 'unit-cost': 25, quantity: 5_000 },
          { operation: 'sell', 'unit-cost': 15, quantity: 10_000 },
          { operation: 'sell', 'unit-cost': 25, quantity: 5_000 }
        ].to_json
      end

      let(:expected_response) do
        [{ tax: 0 }, { tax: 0 }, { tax: 0 }, { tax: 10_000.0 }].to_json
      end

      it 'returns the first tax as zero and the second as 10_000' do
        expect(subject).to  eq(expected_response)
      end
    end

    context 'with Sixth input exemple' do
      let(:input) do
        [
          { operation: 'buy', 'unit-cost': 10, quantity: 10_000 },
          { operation: 'sell', 'unit-cost': 2, quantity: 5_000 },
          { operation: 'sell', 'unit-cost': 20, quantity: 2_000 },
          { operation: 'sell', 'unit-cost': 20, quantity: 2_000 },
          { operation: 'sell', 'unit-cost': 25, quantity: 1_000 }
        ].to_json
      end

      let(:expected_response) do
        [{ tax: 0 }, { tax: 0 }, { tax: 0 }, { tax: 0 }, { tax: 3_000.0 }].to_json
      end

      it 'returns only the last tax as 3_000 and the rest zero' do
        expect(subject).to eq(expected_response)
      end
    end
  end

  context 'With cases not coverage in exercise exemples' do
    context 'When there are new buy and sell operations after selling' do
      let(:input) do
        [
          { operation: 'buy', 'unit-cost': 40, quantity: 1_000 },
          { operation: 'buy', 'unit-cost': 50, quantity: 1_000 },
          { operation: 'sell', 'unit-cost': 55, quantity: 300 },
          { operation: 'sell', 'unit-cost': 57, quantity: 400 },
          { operation: 'buy', 'unit-cost': 30, quantity: 2_000 },
          { operation: 'buy', 'unit-cost': 27, quantity: 1_000 },
          { operation: 'sell', 'unit-cost': 50, quantity: 3_000 }
        ].to_json
      end

      let(:expected_response) do
        [
          { tax: 0 }, # No tax for buy
          { tax: 0 }, # No tax for buy
          { tax: 0 }, # No tax for operation below 20k
          { tax: 960.0 }, # Tax for the 2_800 profit
          { tax: 0 }, # No tax for buy
          { tax: 0 }, # No tax for buy
          { tax: 9_697.67441860465 } # Tax the 57_272 profit
        ].to_json
      end

      it 'returns te expected taxes' do
        expect(subject).to eq(expected_response)
      end
    end

    context 'When the sell has profit but after deducting losses total value goes below 20k' do
      let(:input) do
        [
          { operation: 'buy', 'unit-cost': 100, quantity: 1_000 },
          { operation: 'sell', 'unit-cost': 80, quantity: 250 },
          { operation: 'sell', 'unit-cost': 130, quantity: 184 }
        ].to_json
      end

      let(:expected_response) do
        [
          { tax: 0 }, # No tax for buy
          { tax: 0 }, # No tax for operation had loss
          { tax: 104.0 } # Tax the total profi for 520 since it had profit, and previous losses should not affect the operation total
        ].to_json
      end

      it 'returns te expected taxes' do
        expect(subject).to eq(expected_response)
      end
    end
  end

  context 'when input is invalid' do
    context 'when  input is nil' do
      let(:input) { nil }

      it 'returns error message' do
        expect(subject).to eq('Operations cannot be null or a empty array')
      end
    end

    context 'when  input is empty line' do
      let(:input) { '' }

      it 'returns error message' do
        expect(subject).to eq('Operations cannot be null or a empty array')
      end
    end

    context 'when input is an invalid json' do
      let(:input) { '["invalid": 1]' }

      it 'returns error message' do
        expect(subject).to eq('Invalid json string')
      end
    end

    context 'when the operation has invalid fields' do
      let(:input) do
        [
          { operation: '', 'unit-cost': 40, quantity: 1_000 },
          { operation: 'buy', 'unit-cost': 50, quantity: 1_000 },
          { operation: 'sell', 'unit-cost': 55, quantity: -1 }
        ].to_json
      end

      let(:expected_response) do
        [
          ["The operation must be one of the following: [buy, sell]"],
          [],
          ["The quantity of an operation must be a non-negative Integer"]
        ].to_json
      end

      it 'returns te expected taxes' do
        expect(subject).to eq(expected_response)
      end
    end
  end
end
