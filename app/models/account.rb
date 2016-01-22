class Account < ActiveRecord::Base
  belongs_to :type, class_name: 'AccountType', foreign_key: :account_type_id
  belongs_to :user
  
  validates :type,
             associated: {message: 'exist in the list, you should select instead of adding new one'}
  validates :username, :password,
            presence: true
end
