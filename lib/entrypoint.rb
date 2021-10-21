require_relative './../config/loader'

class Entrypoint
  def self.call(parsed_input)
    ProcessTaxFromProfitInteractor.call(parsed_input)
  end
end
