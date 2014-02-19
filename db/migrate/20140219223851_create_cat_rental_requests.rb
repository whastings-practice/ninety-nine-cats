class CreateCatRentalRequests < ActiveRecord::Migration
  def change
    create_table :cat_rental_requests do |t|
      t.references :cat, index: true, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :status, limit: 10, null: false

      t.timestamps
    end
  end
end
