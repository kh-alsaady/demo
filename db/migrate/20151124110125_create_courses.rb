class CreateCourses < ActiveRecord::Migration
  def up
    create_table :courses do |t|
      t.string :title
      t.references :course_category
      t.string :download_link
      t.boolean :completed
      t.date :taked_at
      t.date :completed_at
      t.text :notes
      t.integer :user_id
      t.timestamps
    end
  end
  
  def down
    drop_table :courses
  end
end
