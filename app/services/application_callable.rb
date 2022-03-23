# frozen_string_literal: true

# Call service execute method
class ApplicationCallable
  class << self
    def call(*args, &)
      new(*args, &).execute
    end
  end
end
