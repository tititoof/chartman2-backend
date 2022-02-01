# frozen_string_literal: true

# Call service execute method
class ApplicationCallable
  def self.call(*args, &block)
    new(*args, &block).execute
  end
end
