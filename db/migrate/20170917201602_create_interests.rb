class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :interest
      t.integer :city_id
    end
  end
end
