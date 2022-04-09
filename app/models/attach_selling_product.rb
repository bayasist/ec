class AttachSellingProduct < ApplicationRecord
  belongs_to :product
  belongs_to :selling_product
end
