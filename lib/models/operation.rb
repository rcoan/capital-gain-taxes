# frozen_string_literal: true

class Operation
  attr_reader :type, :value, :quantity, :errors
  ACCEPTED_OPERATION_TYPES = ['buy', 'sell']

  def initialize(type:, value:, quantity:)
    @type = type
    @value = value.to_f
    @quantity = quantity.to_i
  end

  def valid?
    errors = []

    if ACCEPTED_OPERATION_TYPES.none?(type)
      errors << "The operation must be one of the following: #{ACCEPTED_OPERATION_TYPE}"
    end

    if value.negative?
      errors << "The value of an operation must not be negative"
    end

    if quantity < 1
      errors << "The quantity of an operation must bigger than 1"
    end

    errors.size.positive?
  end
end

