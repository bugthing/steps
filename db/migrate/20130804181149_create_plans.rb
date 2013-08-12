class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.text :name
      t.timestamps
    end
  end
end
