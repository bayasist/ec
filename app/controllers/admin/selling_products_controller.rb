class Admin::SellingProductsController < Admin::ApplicationController
  before_action :get_object, only: [:edit, :update]
  def index
    @products = SellingProductClass.all
  end

  def edit
  end

  def update
    @product.assign_attributes(update_params)
    if @product.save
    else
      flash.now[:alert] = @product.errors.map(&:full_message).join
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def get_object
    @product = SellingProductClass.preload(:selling_products).find(params[:id])
  end

  def update_params
    params.require(:selling_product_class).permit(
      :name,
      :code,
        {
          selling_products_attributes: [
            :id,
            :name,
            :code,
            :price,
            :price_type,
            :tax_type_id
          ]
        })
  end
end
