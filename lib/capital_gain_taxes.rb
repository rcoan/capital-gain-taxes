# frozen_string_literal: true

require './config/loader'

module CapitalGainTaxes
  class Entrypoint
    def self.calculate_taxes(input)
      ProcessTaxFromProfitInteractor.call(input)
    end
  end
end
