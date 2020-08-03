class AddAssetToPurchases < ActiveRecord::Migration[6.0]
  def change
    add_reference :purchases, :asset, null: false, foreign_key: true
  end
end
