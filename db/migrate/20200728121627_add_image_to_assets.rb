class AddImageToAssets < ActiveRecord::Migration[6.0]
  def change
    add_column :assets, :image, :string
  end
end
