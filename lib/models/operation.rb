# frozen_string_literal: true

class Operation
  attr_reader :type, :unit_value, :quantity, :errors
  ACCEPTED_OPERATION_TYPES = ['buy', 'sell']

  def initialize(type:, unit_value:, quantity:)
    @type = type
    @unit_value = unit_value
    @quantity = quantity
  end

  def valid?
    @errors = []

    if ACCEPTED_OPERATION_TYPES.none?(type)
      @errors.push("The operation must be one of the following: #{ACCEPTED_OPERATION_TYPES}")
    end

    if unit_value.nil? || unit_value.negative?
      @errors.push("The unit value of an operation must not be negative")
    end

    if quantity.nil? || quantity.negative? || !quantity.integer?
      @errors.push("The quantity of an operation must be a non-negative Integer")
    end

    @errors.size.zero?
  end
end

