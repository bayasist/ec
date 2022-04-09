class Warehouse < ApplicationRecord
  scope :open, -> { where(deleted_at: nil) }
end
