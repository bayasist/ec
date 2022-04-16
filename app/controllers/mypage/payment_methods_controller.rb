class Mypage::PaymentMethodsController < ApplicationController
  before_action :authenticate_member!

  def create
    current_member.create_stripe_payment_method(payment_method_params[:stripe_paymen_method_id])
  end

  private

  def payment_method_params
    params.require(:payment_method).permit(:stripe_paymen_method_id)
  end
end
