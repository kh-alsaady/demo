class CreateAccounts < ActiveRecord::Migration
  def up
    create_table :accounts do |t|
      t.integer :user_id
      t.string  :username
      t.string  :email
      t.string  :password
      t.integer :account_type_id
      t.string  :other_emails
      t.string  :reason_create
      t.text    :notes
      t.timestamps
    end
  end
  
  def down
    drop_table :accounts
  end
end
