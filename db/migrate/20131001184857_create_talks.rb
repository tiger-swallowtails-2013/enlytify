class CreateTalks < ActiveRecord::Migration
  def up
    create_table :talks do |t|
      t.string :topic
      t.string :speaker
      t.string :date
      t.string :description
      t.string :resources
      t.string :phase
      t.integer :speaker_id

      t.timestamps
    end
  end

  def down
    drop_table :talks
  end
end
