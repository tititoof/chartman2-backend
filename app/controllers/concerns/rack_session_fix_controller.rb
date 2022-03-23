# frozen_string_literal: true

# RackSessionFixController
# Remove session
# Add a fake
module RackSessionFixController
  extend ActiveSupport::Concern

  # FakeRackSession
  # Add a fake
  class FakeRackSession < Hash
    def enabled?
      false
    end
  end

  included do
    before_action :set_fake_rack_session_for_devise

    private

    def set_fake_rack_session_for_devise
      request.env['rack.session'] ||= FakeRackSession.new
    end
  end
end
