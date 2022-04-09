class ProductClassesController < ApplicationController
  before_action :set_product_class, only: [:show]

  def show

  end

  private

  def set_product_class
    @product_class = SellingProductClass.find_by(code: params[:id]) || (raise ActionController::RoutingError.new('Not Found'))
  end
end
