class Admin::SellingProductsController < Admin::ApplicationController
  def index
    @products = SellingProductClass.all
  end

  def edit
    @product = SellingProductClass.preload(:selling_products).find(params[:id])
  end
end
