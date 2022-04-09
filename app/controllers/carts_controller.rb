class CartsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_cart
  before_action :set_product, only: [:add, :delete]
  def add
    @cart.add(@product)
    @cart.save!
    redirect_to cart_path
  end

  def delete
    @cart.delete(@product)
    @cart.save!
    redirect_to cart_path
  end

  def show
  end

  private

  def set_cart
    @cart = Cart.find_or_initialize_by(member_id: current_member.id)
  end

  def set_product
    @product = SellingProduct.find_by!(code: params[:code])
  end
end
