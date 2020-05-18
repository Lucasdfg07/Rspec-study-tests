class CreateWeapons < ActiveRecord::Migration[6.0]
  def change
    create_table :weapons do |t|
      t.string :name
      t.string :description
      t.integer :power_base, default: 3000
      t.integer :power_step, default: 100
      t.integer :level, default: 1
      t.timestamps
    end
  end
end
