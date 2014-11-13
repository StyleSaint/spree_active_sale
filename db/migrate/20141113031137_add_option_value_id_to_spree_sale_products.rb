class AddOptionValueIdToSpreeSaleProducts < ActiveRecord::Migration
  def change
    add_column :spree_sale_products, :option_value_id, :integer, :after => :product_id
  end
end
