class ApplicationController < ActionController::Base
  protect_from_forgery
  include Mobylette::RespondToMobileRequests
  include SessionsHelper
  include ActionView::Helpers::TextHelper
  before_filter :load_side
  before_filter :top_three_teams
  before_filter :top_three_users

  private

  def load_side
    @user = current_user
  	@contents = Content.all 
    @photos = Photo.all
    @allcontents = (@contents + @photos).shuffle.last(2)
  end

  def top_three_teams
    @topthree = Team.all.sort_by(&:team_score).reverse.first(3)
  end

  def top_three_users
    @topthreeusers = User.all.sort_by(&:score).reverse.first(3)
  end
end
