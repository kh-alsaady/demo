class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :category, class_name: :CourseCategory, foreign_key: :course_category_id
  
  validates :title,
            presence: true
  validates :category,
            associated: {message: 'exist in the list, you should select instead of adding new one'}
  
end
