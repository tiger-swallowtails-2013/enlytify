class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :fullname
      t.string :gravatar
      t.string :email
      t.string :github_profile
      t.integer :cohort_id
      t.integer :dbc_student_id

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
