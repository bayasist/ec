class PurchasesController < ApplicationController
  def create
    purchase = Cart.find_by!(member_id: current_member.id, purchase_id: nil).create_purchase!
    redirect_to finish_purchase_path(id: purchase.code)
  end

  def finish
    @purchase = Purchase.find_by!(member_id: current_member.id, code: params[:id])
  end
end
