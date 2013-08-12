class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.text :name
      t.references :plan
      t.timestamps
    end
  end
end
