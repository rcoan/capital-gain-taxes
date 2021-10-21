class Entrypoint
  def self.call
    new.call
  end

  def call
    return [{"tax":0},{"tax":0},{"tax":0}].to_json
  end
end
