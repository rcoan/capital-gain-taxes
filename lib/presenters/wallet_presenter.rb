# frozen_string_literal: true

class WalletPresenter < SimpleDelegator
  def to_json
    taxes.map { |tax| { tax: tax } }.to_json
  end
end
