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

  def shipping_and_payment
    unless @cart.cart_items.size.positive?
      redirect_to cart_path
      return
    end

    @shipping_addresses = current_member.shipping_addresses
    @payment_methods = current_member.payment_methods
    if @cart.shipping_address.blank?
      @cart.shipping_address = current_member.default_shipping_address || @shipping_addresses.first
    end
    if @cart.payment_method.blank?
      @cart.payment_method = current_member.default_payment_method || @payment_methods.first
    end
  end

  def shipping_address
    shipping_address = ShippingAddress.find_by!(member: current_member.id, index: shipping_address_params[:shipping_address_id])
    @cart.update!(shipping_address: shipping_address)
    current_member.update(default_shipping_address: shipping_address)
    redirect_to shipping_and_payment_cart_path
  end

  def payment_method
    payment_method = PaymentMethod.find_by!(member: current_member.id, index: payment_method_params[:payment_method_id])
    @cart.update!(payment_method: payment_method)
    current_member.update(default_payment_method: payment_method)
    redirect_to shipping_and_payment_cart_path
  end

  private

  def set_cart
    @cart = Cart.find_or_initialize_by(member_id: current_member.id, purchase_id: nil)
  end

  def set_product
    @product = SellingProduct.find_by!(code: params[:code])
  end

  def shipping_address_params
    params.require(:cart).permit(:shipping_address_id)
  end

  def payment_method_params
    params.require(:cart).permit(:payment_method_id)
  end
end
