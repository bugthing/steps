class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.text :name
      t.references :node
      t.references :tool
      t.timestamps
    end
  end
end
