class User < ActiveRecord::Base
  acts_as_voter
  acts_as_messageable :table_name => "table_name",
                      :required   => :body,              
                      :dependent  => :destroy             
  
  attr_accessor :password
  attr_accessible :username, :email, :password, :password_confirmation, :score #, :team_id
  
  belongs_to :team
  has_many :contents, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  has_many :comments, :dependent => :destroy  # as: :commentable, 
  #has_many :relationships, :dependent => :destroy,
  # :foreign_key => "follower_id"
  #has_many :reverse_relationships, :dependent => :destroy,
  # :foreign_key => "followed_id",
  # :class_name => "Relationship"
  #has_many :following, :through => :relationships, :source => :followed
  #has_many :followers, :through => :reverse_relationships,
  # :source => :follower

  #include PgSearch
  #multisearchable :against => [:username, :email]
  
  email_regex = /(\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})(,\s*([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,}))*\z)/i
  
  validates :username, :presence => true,
                       :length => { :maximum => 50 },
                       :uniqueness => { :case_sensitive => false }
  validates :email,    :format => { :with => email_regex },
                       :allow_blank => true,
                       :uniqueness => { :case_sensitive => false }
  validates :password, :presence => true, on: :create,
                       :confirmation => true, on: :create,
                       :length => { :within => 6..40 }, on: :create
  validates :password, :presence => true, on: :update,
                       :confirmation => true, on: :update,
                       :length => { :within => 6..40 }, on: :update

  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def send_password_reset
    token = SecureRandom.urlsafe_base64
    if self.password_reset_token == token
      newtoken = SecureRandom.urlsafe_base64
      self.update_column(:password_reset_token, newtoken)
    else
      self.update_column(:password_reset_token, token)
    end
    self.update_column(:password_reset_sent_at, Time.zone.now)
    #save!(:validate => false)
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  class << self
    def authenticate(username, submitted_password)
      user = find_by_username(username)
      (user && user.has_password?(submitted_password)) ? user : nil
    end
    
    def authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
    end
  end

  private
  
    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end
  
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end