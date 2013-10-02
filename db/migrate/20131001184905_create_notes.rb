class CreateNotes < ActiveRecord::Migration
  def up
    create_table :notes do |t|
      t.string :text
      t.integer :author_id
      t.belongs_to :talk
      
      t.timestamps
    end
  end

  def down
    drop_table :notes
  end
end
