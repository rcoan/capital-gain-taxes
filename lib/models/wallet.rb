# frozen_string_literal: true

class Wallet
  attr_reader :weighted_average_cost, :total_stocks, :total_loss, :operations, :taxes

  def initialize(operations:)
    @weighted_average_cost = 0
    @total_loss = 0
    @total_stocks = 0
    @taxes = []
    @operations = operations
  end

  def update(weighted_average_cost: nil,
             total_stocks: nil,
             operation_tax: nil,
             total_loss: nil)
    @weighted_average_cost = weighted_average_cost unless weighted_average_cost.nil?
    @total_stocks = total_stocks unless total_stocks.nil?
    @total_loss = total_loss unless total_loss.nil?
    @taxes.push(operation_tax) unless operation_tax.nil?
  end

  def valid?
    true
  end
end
