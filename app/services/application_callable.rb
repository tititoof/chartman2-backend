# frozen_string_literal: true

# Call service execute method
class ApplicationCallable
  def self.call(*args, &)
    new(*args, &).execute
  end
end
