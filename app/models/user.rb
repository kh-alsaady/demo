class User < ActiveRecord::Base
  belongs_to :role
  has_many :courses, dependent: :destroy
  has_many :accounts, dependent: :destroy
  has_many :books, dependent: :destroy
  
  # for paperclip support
  has_attached_file :image, styles: { small: '150x150'}, default_url: 'images/user.png'
  do_not_validate_attachment_file_type :image
  
  attr_accessor  :password
  
  before_create :before_create
  before_update :before_update
  after_save    :after_save
  before_destroy :prevent_destroy_main_user
  
  validates :first_name, :last_name, :display_name, :username,
            presence: true
  validates :password, :password_confirmation,
            confirmation: true,
            presence: true,
            allow_nil: false,
            allow_blank: false,
            on: :create
  validates :username,
            uniqueness: true  
            
  def name
    [first_name, last_name].join(' ')
  end
  
  def self.make_salt(string)
    Digest::SHA1.hexdigest(string + Time.now.to_s)
  end
  
  def self.hash_with_salt(password, salt)
    return Digest::SHA1.hexdigest("put #{salt} on #{password}")
  end
  
  def authenticated?(password)
    self.hashed_password == User.hash_with_salt(password, self.salt)
  end
  
  def self.authenticate(username,  password)
    user =  self.where(["username = ?", username]).first 
    ( user && user.authenticated?(password) ) ? user : nil
  end
  
  private #------------------------------
    def before_create
      self.salt            = User.make_salt(self.username)
      self.hashed_password  = User.hash_with_salt(@password,  self.salt)
    end
  
    def before_update
      if !@password.nil?
        self.salt            = User.make_salt(self.username) if self.salt.nil?
        self.hashed_password  = User.hash_with_salt(@password,  self.salt)
      end
    end
    
    def after_save
      @password = nil
    end
    
    def prevent_destroy_main_user
      if self.id == 1
        #errors[:base] << "this is the main administrator, You can't delete the main Adminstrator"
      end
    end
end


