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

    it 'returns all taxes as zero' do
      expect(subject).to  eq([{"tax":0},{"tax":0},{"tax":0}].to_json)
    end
  end

  context 'Second input exemple' do
    let(:input) do
      [
        {"operation":"buy", "unit-cost": 10, "quantity": 10000},
        {"operation":"sell", "unit-cost":20, "quantity": 5000},
        {"operation":"sell", "unit-cost":5, "quantity":5000 }
      ].to_json
    end

  end

  context 'Third input exemple' do
    let(:input) do
      [
        {"operation":"buy", "unit-cost": 10, "quantity": 10000},
        {"operation":"sell", "unit-cost":5, "quantity": 5000},
        {"operation":"sell", "unit-cost":20, "quantity":5000 }
      ].to_json
    end
  end

  context 'Fourth input exemple' do
    let(:input) do
      [
        {"operation":"buy", "unit-cost": 10, "quantity": 10000},
        {"operation":"buy", "unit-cost":25, "quantity": 5000},
        {"operation":"sell", "unit-cost":15, "quantity":10000 }
      ].to_json
    end
  end

  context 'Fifth input exemple' do
    let(:input) do
      [
        {"operation":"buy", "unit-cost": 10, "quantity": 10000},
        {"operation":"buy", "unit-cost":25, "quantity": 5000},
        {"operation":"sell", "unit-cost":15, "quantity":10000 },
        {"operation":"sell", "unit-cost":25, "quantity": 5000}
      ].to_json
    end
  end

  context 'Sixth input exemple' do
    let(:input) do
      [
        {"operation":"buy", "unit-cost": 10, "quantity": 10000},
        {"operation":"sell", "unit-cost":2, "quantity": 5000},
        {"operation":"sell", "unit-cost":20, "quantity":2000 },
        {"operation":"sell", "unit-cost":20, "quantity": 2000},
        {"operation":"sell", "unit-cost":25, "quantity": 1000}
      ].to_json
    end
  end
end
