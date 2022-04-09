class TopController < ApplicationController
  def index
    @product_classes = SellingProductClass.all
  end
end
