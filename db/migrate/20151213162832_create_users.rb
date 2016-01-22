class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.integer :role_id
      t.string :username
      t.string :hashed_password
      t.string :salt
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :display_name
      t.string :image
      t.text :description
      t.date :birthdate
      t.timestamps
    end
  end
  
  def down
    drop_table :users
  end
end
