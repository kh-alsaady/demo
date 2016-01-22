class AccountType < ActiveRecord::Base
  has_many :accounts, dependent: :destroy
    
  validates :name,
           uniqueness: {case_sensitive: false}
             
  
end
