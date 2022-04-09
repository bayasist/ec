class SellingProduct < ApplicationRecord
  belongs_to :selling_product_class
  has_many :attach_selling_products

  # 残り在庫数を返す
  # @return [Integer, nil] 在庫管理しなくてもよいものはnilを返却する
  def allowable_quantity
    return nil unless manaage_stock?

    Warehouse.open.sum do |warehouse|
      allowable_quantity_by_warehouse(warehouse)
    end
  end

  # 残り在庫数を返す
  # @params [Warehouse] warehouse 対象の倉庫
  # @return [Integer, nil] 在庫管理しなくてもよいものはnilを返却する
  def allowable_quantity_by_warehouse(warehouse)
    return nil unless manaage_stock?

    attach_selling_products.map do |attach_product|
      attach_product.product.allowable_quantity_by_warehouse(warehouse) / attach_product.quantity
    end.min
  end

  # 在庫管理をする必要のある商品かどうか
  # @return [true, false] trueの場合は在庫管理の必要のある商品
  def manaage_stock?
    attach_selling_products.size.positive?
  end
end
