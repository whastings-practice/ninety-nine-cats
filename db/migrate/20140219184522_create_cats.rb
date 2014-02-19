class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name, null: false
      t.integer :age
      t.date :birth_date
      t.string :color, limit: 20
      t.string :sex, limit: 1

      t.timestamps
    end
  end
end
