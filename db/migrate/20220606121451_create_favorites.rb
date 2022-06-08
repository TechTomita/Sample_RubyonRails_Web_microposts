class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: {to_table: :microposts}

      t.timestamps
      
      t.index [:user_id, :post_id], unique: true
    end
  end
end
