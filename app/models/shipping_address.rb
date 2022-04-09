class ShippingAddress < ApplicationRecord
  belongs_to :member

  before_create :add_index

  private

  def add_index
    return if index.present?
    self.index = (ShippingAddress.where(member_id: member.id).pluck(:index).max || 0) + 1
  end
end
