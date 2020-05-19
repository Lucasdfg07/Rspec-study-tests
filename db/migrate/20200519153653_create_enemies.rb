class CreateEnemies < ActiveRecord::Migration[6.0]
  def change
    create_table :enemies do |t|
      t.string :name
      t.integer :power_base
      t.integer :power_step
      t.integer :level
      t.integer :kind

      t.timestamps
    end
  end
end
