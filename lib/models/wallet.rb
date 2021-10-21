class Wallet
  attr_reader :weighted_average, :total_stocks, :total_profit, :operations

  def initialize(operations:)
    @weighted_average = 0
    @total_profit = 0
    @total_stocks = 0
    @operations = operations
  end
end
