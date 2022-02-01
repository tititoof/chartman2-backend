# frozen_string_literal: true

# Base class active record
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
