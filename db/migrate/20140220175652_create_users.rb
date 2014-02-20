class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, null: false, limit: 50
      t.string :password_digest, null: false, limit: 60
      t.string :session_token, null: false, limit: 100

      t.timestamps
    end
    add_index :users, :session_token, unique: true
  end
end
