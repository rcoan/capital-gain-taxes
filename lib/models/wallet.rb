class Wallet
  attr_reader :weighted_average, :total_stocks, :total_profit, :operations, :taxes

  def initialize(operations:)
    @weighted_average = 0
    @total_profit = 0
    @total_stocks = 0
    @taxes = []
    @operations = operations
  end

  def update(weighted_average: nil, total_stocks: nil)
    @weighted_average = weighted_average unless weighted_average.nil?
    @total_stocks = total_stocks unless total_stocks.nil?
  end
end
