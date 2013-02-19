class Team < ActiveRecord::Base

  attr_accessible :team_name, :team_score, :user1, :user_id1, :user2, :user_id2, :user3, :user_id3, :email

  has_many :users  

  before_create :check_for_users
  after_create :match_users_to_team_id

  email_regex = /(\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})(,\s*([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,}))*\z)/i

  validates :email,    :presence => true,
  					           :format => { :with => email_regex },
                       :allow_blank => false,
                       :uniqueness => { :case_sensitive => false }
  validates :team_name, :presence => true,
                       :allow_blank => false,
                       :uniqueness => { :case_sensitive => false }
  validates :user1,    :presence => true,
                       :allow_blank => false,
                       :uniqueness => { :case_sensitive => false }
  validates :user2,    :presence => true,
                      :allow_blank => false,
                      :uniqueness => { :case_sensitive => false }
  validates :user3,    :presence => true,
                      :allow_blank => false,
                      :uniqueness => { :case_sensitive => false }
  
  validate :check_for_users_error_messages

  private

  def check_for_users
    firstuser = self.user1
    firstuserstring = self.user1.to_s
    user1 = User.find_by_username(firstuserstring)
    seconduser = self.user2
    seconduserstring = self.user2.to_s
    user2 = User.find_by_username(seconduserstring)
    thirduser = self.user3
    thirduserstring = self.user3.to_s
    user3 = User.find_by_username(thirduserstring)

    return false unless User.find_by_username(self.user1) != User.find_by_username(self.user2) && User.find_by_username(self.user1) != User.find_by_username(self.user3) && User.find_by_username(self.user2) != User.find_by_username(self.user3) && User.find_by_username(self.user1).team_id.nil? && User.find_by_username(self.user2).team_id.nil? && User.find_by_username(self.user3).team_id.nil?
  end

  def match_users_to_team_id
    #user = self.user
    #user.update_column(:team_id, self.id)

    firstuser = self.user1
    firstuserstring = self.user1.to_s
    user1 = User.find_by_username(firstuserstring)
    self.user_id1 = user1.id
    user1.team_id = self.id
  	seconduser = self.user2
  	seconduserstring = self.user2.to_s
  	user2 = User.find_by_username(seconduserstring)
  	self.user_id2 = user2.id
  	user2.team_id = self.id
  	thirduser = self.user3
  	thirduserstring = self.user3.to_s
  	user3 = User.find_by_username(thirduserstring)
  	self.user_id3 = user3.id
  	user3.team_id = self.id  
  
    #if user1.team_id.nil? and user2.team_id.nil? and user3.team_id.nil?
     if User.find_by_username(self.user1) != User.find_by_username(self.user2) && User.find_by_username(self.user1) != User.find_by_username(self.user3) && User.find_by_username(self.user2) != User.find_by_username(self.user3) && User.find_by_username(self.user1).team_id.nil? && User.find_by_username(self.user2).team_id.nil? && User.find_by_username(self.user3).team_id.nil?
      user1.update_column(:team_id, self.id)
      user2.update_column(:team_id, self.id)
      user3.update_column(:team_id, self.id)
      self.update_column(:user1, user1.username)
      self.update_column(:user_id1, user1.id)
      self.update_column(:user2, user2.username)
      self.update_column(:user_id2, user2.id)
      self.update_column(:user3, user3.username)
      self.update_column(:user_id3, user3.id)   
      return true 
    else
    self.destroy   
    return false
    end   
  end

  def check_for_users_error_messages
    unless User.find_by_username(self.user1) != User.find_by_username(self.user2) && User.find_by_username(self.user1) != User.find_by_username(self.user3) && User.find_by_username(self.user2) != User.find_by_username(self.user3) && User.find_by_username(self.user1).team_id.nil? && User.find_by_username(self.user2).team_id.nil? && User.find_by_username(self.user3).team_id.nil?
      errors.add(:base, "Users must exist, cannot be in a team already, or be put in more than once.")    
    end 
  end

end
