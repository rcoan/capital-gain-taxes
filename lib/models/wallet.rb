# frozen_string_literal: true

class Wallet
  attr_reader :weighted_average_cost, :total_stocks, :total_profit, :operations, :taxes

  def initialize(operations:)
    @weighted_average_cost = 0
    @total_profit = 0
    @total_stocks = 0
    @taxes = []
    @operations = operations
  end

  def update(weighted_average_cost: nil,
             total_stocks: nil,
             operation_tax: nil,
             total_profit: nil)
    @weighted_average_cost = weighted_average_cost unless weighted_average_cost.nil?
    @total_stocks = total_stocks unless total_stocks.nil?
    @total_profit = total_profit unless total_profit.nil?
    @taxes.push(operation_tax) unless operation_tax.nil?
  end
end
