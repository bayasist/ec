class PurchasesController < ApplicationController
  def create
    purchase = nil
    ActiveRecord::Base.transaction do
      purchase = Cart.find_by!(member_id: current_member.id, purchase_id: nil).create_purchase!
      purchase.reserve_stock!
    end
    redirect_to finish_purchase_path(id: purchase.code)
  end

  def finish
    @purchase = Purchase.find_by!(member_id: current_member.id, code: params[:id])
  end
end
