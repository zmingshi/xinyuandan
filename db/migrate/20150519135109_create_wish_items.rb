class CreateWishItems < ActiveRecord::Migration
  def change
    create_table :wish_items do |t|
      t.string :title
      t.text :url
      t.integer :mark
      t.boolean :flag
      t.integer :user_id

      t.timestamps
    end
	add_index :wish_items, [:user_id, :created_at]
  end
end
