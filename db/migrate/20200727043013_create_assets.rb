class CreateAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :assets do |t|
      t.string :title
      t.text :description
      t.text :content
      t.integer :price

      t.timestamps
    end
  end
end
