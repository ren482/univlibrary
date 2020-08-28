class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :icon_image
      t.string :password_digest
      t.string :major
      t.string :academic_level
      t.string :profile_content

      t.timestamps
    end
  end
end
