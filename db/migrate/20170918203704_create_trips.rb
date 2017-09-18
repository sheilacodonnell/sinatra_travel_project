class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :city
      t.string :interests
      t.string :notes
      t.integer :user_id
    end
  end
end
