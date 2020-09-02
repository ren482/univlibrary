class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :purpose
      t.string :sentences
      t.string :discovery
      t.string :summary
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
