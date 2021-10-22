# frozen_string_literal: true

require './config/loader'
class Entrypoint
  def self.call(input)
    ProcessTaxFromProfitInteractor.call(input)
  end
end
