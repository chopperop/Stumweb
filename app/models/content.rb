class Content < ActiveRecord::Base
  acts_as_votable
  is_impressionable :counter_cache => { :column_name => :impressions_count, :unique => true }
  
  attr_accessible :content, :content_changed_at #, :captions_attributes

  before_create :init_sort_column

  after_update :update_user_score
  after_destroy :update_user_score

  belongs_to :user
  has_many :comments, as: :commentable, :dependent => :destroy 
  #has_many :captions, :dependent => :destroy
  #accepts_nested_attributes_for :captions

  #include PgSearch
  #multisearchable :against => :content
  
  validates :content, :presence => true, :length => { :maximum => 50000 }   # spam protection
  #:allow_blank => true is needed to be able to upload images
  #validates :image, :presence => true
  validates :user_id, :presence => true
  
  default_scope :order => 'contents.created_at DESC'

  def self.search(search)
    if search
      find(:all, :conditions => ['content LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  private

  def init_sort_column
    self.content_changed_at = self.created_at || Time.now
  end

  def update_user_score
    if self.user
      user = self.user
      everything = user.contents + user.photos
      likes_count = everything.inject(0) {|sum, f| sum + f.likes.count}
      dislikes_count = everything.inject(0) {|sum, f| sum + f.dislikes.count}
      unique_views = everything.inject(0) {|sum, f| sum + f.impressionist_count}
      score = ((2 * unique_views) + (likes_count - dislikes_count))
      user.update_column(:score, score)

      if user.team
        team = user.team
        teammates = team.users
        teamscore = teammates.inject(0) {|sum, f| sum + f.score}
        team.update_column(:team_score, teamscore) 
      end
    end
  end
end
