class CourseCategory < ActiveRecord::Base
  has_many :courses, dependent: :nullify
  has_many :books, dependent: :nullify
  
  validates :name,
           uniqueness: {case_sensitive: false}
end
