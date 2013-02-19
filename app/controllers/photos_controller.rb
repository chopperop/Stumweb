class PhotosController < ApplicationController
  before_filter :authenticate, :except => :show
  before_filter :authorized_user, :only => :destroy
  impressionist :actions => [:show], :unique => [:impressionable_type, :impressionable_id, :session_hash]
  
  def home
    @title = "Home"
      if signed_in?
        @photo = photo.new
        @feed_items = photo.all #.paginate(:page => params[:page])
      end
      if signed_out?
        @feed_items = photo.all #.paginate(:page => params[:page])
      end
  end

  def index
    @photos = Photo.all
    @search = Photo.search(params[:search])
  end

  def like
    @user = current_user
    @photo = Photo.find(params[:id])
    @user.likes @photo
        
    everything = @user.contents + @user.photos
    likes_count = everything.inject(0) {|sum, f| sum + f.likes.count}
    dislikes_count = everything.inject(0) {|sum, f| sum + f.dislikes.count}
    unique_views = everything.inject(0) {|sum, f| sum + f.impressionist_count}
    score = ((2 * unique_views) + (likes_count - dislikes_count))
    @user.update_column(:score, score)

    sign_in @user
    redirect_to root_path
  end

  def dislike
    @user = current_user
    @photo = Photo.find(params[:id])
    @user.dislikes @photo
    
    everything = @user.contents + @user.photos
    likes_count = everything.inject(0) {|sum, f| sum + f.likes.count}
    dislikes_count = everything.inject(0) {|sum, f| sum + f.dislikes.count}
    unique_views = everything.inject(0) {|sum, f| sum + f.impressionist_count}
    score = ((2 * unique_views) + (likes_count - dislikes_count))
    @user.update_column(:score, score)

    sign_in @user
    redirect_to root_path
  end

  def new 
    @photo = Photo.new
    @photo.captions.build
  end

  def show
    @photo = Photo.find(params[:id])
    @topcomments = @photo.comments.sort_by(&:cached_votes_up).last(4).shuffle.last(2)
    @comments = @photo.comments.sort_by(&:created_at).reverse.paginate(page: params[:page], :per_page => 7)
  end

  def create
    @photo = current_user.photos.build(params[:photo])
    @photo.image = params[:file]
    if @photo.save
      redirect_to root_path, :flash => { :success => "photo created!" }
    else
      redirect_to root_path
    end
  end

  def destroy
    @photo.destroy
    redirect_to root_path, :flash => { :success => "photo deleted!" }
  end
  
  private
  
    def authorized_user
      if current_user.admin?
        @photo = Photo.find(params[:id])
        @photo.destroy
        redirect_to root_path, :flash => { :success => "photo deleted!" }
      else
        @photo = current_user.photos.find_by_id(params[:id])
        redirect_to root_path if @photo.nil?
      end
    end
end