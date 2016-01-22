class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references :course_category
      t.references :user
      t.string     :title
      t.boolean    :completed
      t.date       :started_at
      t.date       :finshed_at
      t.text       :notes
      t.timestamps
    end
  end
end
