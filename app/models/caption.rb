class Caption < ActiveRecord::Base
  attr_accessible :body, :photo_id

  belongs_to :photo

  #include PgSearch
  #multisearchable :against => :body

  #validates :content_id, :presence => true
  validates :body, :presence => true, :length => { :maximum => 50000 }  
end
