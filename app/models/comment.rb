class Comment < ActiveRecord::Base
  acts_as_votable
  
  attr_accessible :body

  after_create :update_parent_sort_column

  belongs_to :user
  #belongs_to :content
  #belongs_to :photo         
  belongs_to :commentable, polymorphic: true
  #has_many :comments, as: :commentable

  #include PgSearch
  #multisearchable :against => :body

  validates :user_id, :presence => true
  #validates :content_id, :presence => true
  #validates :photo_id, :presence => true
  validates :body, :presence => true, :length => { :maximum => 50000 }     # spam protection

  default_scope :order => 'comments.created_at DESC'

  private
  def update_parent_sort_column
    if self.commentable
      self.commentable.content_changed_at = self.created_at
      self.commentable.save
    end
  end
end
