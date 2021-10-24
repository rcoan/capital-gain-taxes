# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Operation do
  subject { described_class.new(type: type, unit_value: unit_value, quantity: quantity) }

  describe '#valid?' do
    context 'when all fields are valid' do
      let(:type) { 'buy' }
      let(:unit_value) { 1 }
      let(:quantity) { 0 }

      it 'returns true' do
        expect(subject.valid?).to be(true)
      end

      it 'returns error as an empty array' do
        subject.valid?
        expect(subject.errors).to eq([])
      end
    end

    context 'when type is NOT valid' do
      let(:type) { 'foo' }
      let(:unit_value) { 1 }
      let(:quantity) { 1 }

      it 'returns true' do
        expect(subject.valid?).to be(false)
      end

      it 'returns error as an array with correct error' do
        subject.valid?
        expect(subject.errors).to eq(["The operation must be one of the following: [\"buy\", \"sell\"]"])
      end
    end

    context 'when unit_value is NOT valid' do
      let(:type) {  'sell'}
      let(:unit_value) { -1 }
      let(:quantity) { 1 }

      it 'returns true' do
        expect(subject.valid?).to be(false)
      end

      it 'returns error as an array with correct error' do
        subject.valid?
        expect(subject.errors).to eq(["The unit value of an operation must not be negative"])
      end
    end

    context 'when quantity is NOT valid' do
      let(:type) { 'buy' }
      let(:unit_value) { 0 }
      let(:quantity) { -1 }

      it 'returns true' do
        expect(subject.valid?).to be(false)
      end

      it 'returns error as an array with correct error' do
        subject.valid?
        expect(subject.errors).to eq(["The quantity of an operation must be a non-negative Integer"])
      end
    end
  end
end
