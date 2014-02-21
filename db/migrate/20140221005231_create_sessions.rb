class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :token, null: false
      t.references :user, index: true, null: false

      t.timestamps
    end
    add_index :sessions, :token, unique: true
  end
end
