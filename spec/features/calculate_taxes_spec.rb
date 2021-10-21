# frozen_string_literal: true

require 'spec_helper'
require 'json'

RSpec.describe 'Calculate taxes' do
  subject { Entrypoint.call }

  context 'First input exemple' do
    let(:input) do
      [
        {"operation":"buy", "unit-cost": 10, "quantity": 100},
        {"operation":"sell", "unit-cost":15, "quantity": 50},
        {"operation":"sell", "unit-cost":15, "quantity":50 }
      ].to_json
    end

    let(expected_response) do
      [{"tax":0},{"tax":0}].to_json
    end

    it 'returns all taxes as zero' do
      expect(subject).to  eq(expected_response)
    end
  end

  context 'Second input exemple' do
    let(:input) do
      [
        {"operation":"buy", "unit-cost": 10, "quantity": 10_000},
        {"operation":"sell", "unit-cost":20, "quantity": 5_000},
        {"operation":"sell", "unit-cost":5, "quantity":5_000 }
      ].to_json
    end

    let(expected_response) do
      [{"tax":10_000},{"tax":0}].to_json
    end

    it 'returns the first tax as 10_000 and the secon zero' do
      expect(subject).to  eq(expected_response)
    end
  end

  context 'Third input exemple' do
    let(:input) do
      [
        {"operation":"buy", "unit-cost": 10, "quantity": 10_000},
        {"operation":"sell", "unit-cost":5, "quantity": 5_000},
        {"operation":"sell", "unit-cost":20, "quantity":5_000 }
      ].to_json
    end

    let(expected_response) do
      [{"tax":0},{"tax":5_000}].to_json
    end

    it 'returns the first tax as zero and the second as 5_000' do
      expect(subject).to  eq(expected_response)
    end
  end

  context 'Fourth input exemple' do
    let(:input) do
      [
        {"operation":"buy", "unit-cost": 10, "quantity": 10_000},
        {"operation":"buy", "unit-cost":25, "quantity": 5_000},
        {"operation":"sell", "unit-cost":15, "quantity":10_000 }
      ].to_json
    end

    let(expected_response) do
      [{"tax":0}].to_json
    end

    it 'returns the only sell tax as zero' do
      expect(subject).to  eq(expected_response)
    end
  end

  context 'Fifth input exemple' do
    let(:input) do
      [
        {"operation":"buy", "unit-cost": 10, "quantity": 10_000},
        {"operation":"buy", "unit-cost":25, "quantity": 5_000},
        {"operation":"sell", "unit-cost":15, "quantity":10_000 },
        {"operation":"sell", "unit-cost":25, "quantity": 5_000}
      ].to_json
    end

    let(expected_response) do
      [{"tax":0},{"tax":10_000}].to_json
    end

    it 'returns the first tax as zero and the second as 10_000' do
      expect(subject).to  eq(expected_response)
    end
  end

  context 'Sixth input exemple' do
    let(:input) do
      [
        {"operation":"buy", "unit-cost": 10, "quantity": 10_000},
        {"operation":"sell", "unit-cost":2, "quantity": 5_000},
        {"operation":"sell", "unit-cost":20, "quantity":2_000 },
        {"operation":"sell", "unit-cost":20, "quantity": 2_000},
        {"operation":"sell", "unit-cost":25, "quantity": 1_000}
      ].to_json
    end

    let(expected_response) do
      [{"tax":0},{"tax":0},{"tax":0},{"tax":3_000}].to_json
    end

    it 'returns only the last tax as 3_000 and the rest zero' do
      expect(subject).to  eq(expected_response)
    end
  end
end
