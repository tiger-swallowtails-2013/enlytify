class CreateNotes < ActiveRecord::Migration
  def up
    create_table :notes do |t|
      t.string :text
      t.belongs_to :talk
      t.belongs_to :user

      t.timestamps
    end
  end

  def down
    drop_table :notes
  end
end
