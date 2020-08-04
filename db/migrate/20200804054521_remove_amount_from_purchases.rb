class RemoveAmountFromPurchases < ActiveRecord::Migration[6.0]
  def change
    remove_column :purchases, :amount, :integer
  end
end
