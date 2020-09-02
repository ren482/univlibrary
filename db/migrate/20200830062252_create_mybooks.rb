class CreateMybooks < ActiveRecord::Migration[5.2]
  def change
    create_table :mybooks do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :book_id]
    end
  end
end
