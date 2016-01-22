class CreateCourseCategories < ActiveRecord::Migration
  def up
    create_table :course_categories do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def down
    drop_table :course_categories
  end
end
