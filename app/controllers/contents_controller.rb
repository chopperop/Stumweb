class ContentsController < ApplicationController
  before_filter :authenticate, :except => :show
  before_filter :authorized_user, :only => :destroy
  impressionist :actions => [:show], :unique => [:impressionable_type, :impressionable_id, :session_hash]

  def home
    @title = "Home"
      if signed_in?
        @content = content.new
        @feed_items = content.all #.paginate(:page => params[:page])
      end
      if signed_out?
        @feed_items = content.all #.paginate(:page => params[:page])
      end
  end

  def index
    @results = Content.search(params[:search])
  end

  def like
    @user = current_user
    @content = Content.find(params[:id])
    @user.likes @content

    redirect_to root_path
  end

  def dislike
    @user = current_user
    @content = Content.find(params[:id])
    @user.dislikes @content

    redirect_to root_path
  end

  def new 
    @content = Content.new
    @content.captions.build
  end

  def show
    @content = Content.find(params[:id])
    @topcomments = @content.comments.sort_by(&:cached_votes_up).last(4).shuffle.last(2)
    @comments = @content.comments.sort_by(&:created_at).reverse.paginate(page: params[:page], :per_page => 7)
  end

  def create
    @content = current_user.contents.build(params[:content])
    if @content.save
      redirect_to root_path, :flash => { :success => "content created!" }
    else
      redirect_to root_path
    end
  end

  def destroy
      @content.destroy
      redirect_to root_path, :flash => { :success => "content deleted!" }
  end
  
  private
  
    def authorized_user
      if current_user.admin?
        @content = Content.find(params[:id])
        @content.destroy
        redirect_to root_path, :flash => { :success => "content deleted!" }
      else
        @content = current_user.contents.find_by_id(params[:id])
        redirect_to root_path if @content.nil?
      end
    end
end
