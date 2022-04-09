require 'rails_helper'

RSpec.describe SellingProduct, type: :model do
  describe "#allowable_quantity" do
    subject { selling_product.allowable_quantity }

    let(:selling_product_class) { create(:selling_product_class) }
    let(:selling_product) { create(:selling_product, selling_product_class: selling_product_class) }

    context "在庫管理の必要がない商品の場合" do
      it { is_expected.to be nil }
    end

    context "一種類の在庫管理をする商品が紐づいている場合" do
      let(:allowable_stocks) {
        { create(:warehouse) => 1, create(:warehouse) => 5 }
      }
      let(:warehouses) { allowable_stocks.keys }
      let(:product) { create(:product) }
      let!(:stocks) { warehouses.map { |w| create(:stock, product: product, warehouse: w, allowable_quantity: allowable_stocks[w]) } }
      let!(:attach_selling_product) { create(:attach_selling_product, product: product, selling_product: selling_product) }
      
      it "各倉庫の在庫の合計を返す" do
        expect(subject).to be allowable_stocks.values.sum
      end
    end

    context "一種類の在庫管理をする商品が複数紐づいている場合" do
      let(:allowable_stocks) {
        { create(:warehouse) => 199, create(:warehouse) => 100 }
      }
      let(:count) { 2 }
      let(:warehouses) { allowable_stocks.keys }
      let(:product) { create(:product) }
      let!(:stocks) { warehouses.map { |w| create(:stock, product: product, warehouse: w, allowable_quantity: allowable_stocks[w]) } }
      let!(:attach_selling_product) { create(:attach_selling_product, product: product, selling_product: selling_product, quantity: count) }
      
      it "各倉庫の在庫の合計を返す" do
        expect(subject).to be allowable_stocks.values.map { |v| v / count }.sum
      end
    end

    context "複数の在庫管理をする商品が複数紐づいている場合" do
      let(:allowable_stocks) {
        { warehouses[0] => { products[0] => 100, products[1] => 199}, warehouses[1] => { products[0] => 199, products[1] => 100} }
      }
      let(:warehouses) { create_list(:warehouse, 2) }
      let(:products) { create_list(:product, 2) }
      let!(:stocks) { warehouses.map { |w| products.map { |p| create(:stock, product: p, warehouse: w, allowable_quantity: allowable_stocks[w][p]) } } }
      let!(:attach_selling_products) { products.map { |p| create(:attach_selling_product, product: p, selling_product: selling_product) } }
      
      it "各倉庫の在庫の合計を返す" do
        expect(subject).to be warehouses.sum { |w| products.map { |p| allowable_stocks[w][p] }.min }
      end
    end

  end
end
