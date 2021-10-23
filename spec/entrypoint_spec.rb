# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CapitalGainTaxes::Entrypoint do
  describe '#calculate_taxes' do
    it 'calls the correct interactor for the user case' do
      input = [
        { operation: 'buy', 'unit-cost': 10, quantity: 100 },
        { operation: 'sell', 'unit-cost': 15, quantity: 50 },
        { operation: 'sell', 'unit-cost': 15, quantity: 50 }
      ].to_json

      allow(ProcessTaxFromProfitInteractor).to receive(:call)
      expect(ProcessTaxFromProfitInteractor).to receive(:call).with(input)

      described_class.calculate_taxes(input)
    end
  end
end
