class CreateNotes < ActiveRecord::Migration
  def up
    create_table :notes do |t|
      t.string :text

      t.timestamps
    end
  end

  def down
    drop_table
  end
end
