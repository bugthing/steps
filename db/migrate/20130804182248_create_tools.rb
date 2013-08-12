class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.text :name
      t.text :class_name
      t.timestamps
    end
  end
end
