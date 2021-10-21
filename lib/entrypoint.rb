  require './config/loader'
class Entrypoint

  def self.call(parsed_input)
    binding.pry
    ProcessTaxFromProfitInteractor.call(parsed_input)
  end
end
