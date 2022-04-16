class PurchaseProduct < ApplicationRecord
  belongs_to :selling_product

  def reserve_stock!(warehouse = nil)
    if warehouse.blank?
      warehouse = Warehouse.first # TODO* あとでちゃんとしたロジックへ
    end

    selling_product.attach_selling_products.each do |attach|
      stock = attach.product.stock_by_warehouse(warehouse)
      stock.commence!(attach.quantity, { purchase_product: self })
    end
  end
end
