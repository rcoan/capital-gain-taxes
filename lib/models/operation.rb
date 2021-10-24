# frozen_string_literal: true

class Operation
  attr_reader :type, :unit_value, :quantity, :errors
  ACCEPTED_OPERATION_TYPES = ['buy', 'sell']

  def initialize(type:, unit_value:, quantity:)
    @type = type
    @unit_value = unit_value.to_f
    @quantity = quantity.to_i
  end

  def valid?
    errors = []

    if ACCEPTED_OPERATION_TYPES.none?(type)
      errors << "The operation must be one of the following: #{ACCEPTED_OPERATION_TYPE}"
    end

    if unit_value.negative?
      errors << "The unit value of an operation must not be negative"
    end

    if quantity < 1
      errors << "The quantity of an operation must bigger than 1"
    end

    errors.size.positive?
  end
end

