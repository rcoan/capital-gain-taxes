class WalletPressenter < SimpleDelegator
  def json_formatted_taxes
    taxes.map { |tax| { tax: tax } }.to_json
  end
end
