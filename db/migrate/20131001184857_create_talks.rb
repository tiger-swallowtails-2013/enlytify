class CreateTalks < ActiveRecord::Migration
  def up
    create_table :talks do |t|
      t.string :topic
      t.string :description
      t.string :resources
      t.string :phase

      t.timestamps
    end
  end

  def down
    drop_table
  end
end
