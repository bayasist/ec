class Stock < ApplicationRecord
  belongs_to :product
  belongs_to :warehouse

  # しかかる
  def commence!(quantity, reason)
    lock!
    raise "inventory shortage" if self.allowable_quantity - quantity < 0
    raise "inventory shortage" if self.process_quantity + quantity < 0
    increment!(:process_quantity, quantity)
    decrement!(:allowable_quantity, quantity)
    reload
    record = build_stock_record(reason)
    record.process_increase = quantity
    record.allowable_increase = -quantity
    record.save!
  end

  # 入荷する
  def arrive!(quantity, reason)
    lock!
    increment!(:quantity, quantity)
    increment!(:allowable_quantity, quantity)
    reload
    record = build_stock_record(reason)
    record.increase = quantity
    record.allowable_increase = quantity
    record.save!
  end

  private

  def build_stock_record(reason)
    result = StockRecord.new(
      warehouse: warehouse,
      product: product,
      quantity: quantity,
      allowable_quantity: allowable_quantity,
      process_quantity: process_quantity,
      bad_quantity: bad_quantity,
      hold_quantity: hold_quantity,
      increase:0,
      allowable_increase: 0,
      process_increase: 0,
      bad_increase: 0,
      hold_increase: 0
    )
    if reason[:purchase_product]
      result.purchase_product = reason[:purchase_product]
    end
    result
  end
end
