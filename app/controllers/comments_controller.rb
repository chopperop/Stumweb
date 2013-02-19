class CommentsController < ApplicationController
  before_filter :authenticate, :except => :index
  before_filter :authorized_user, :only => :destroy
  before_filter :load_commentable
  
  def home
    @title = "Home"
      if signed_in?
        @comment = comment.new
        @feed_items = comment.all #.paginate(:page => params[:page])
      end
      if signed_out?
        @feed_items = comment.all #.paginate(:page => params[:page])
      end
  end

  def index
    #@content = Content.find(params[:content_id])
    #@comments = @content.comments #.paginate(:page => params[:page])
    #@title = @user.username
    @comments = load_commentable.comments.sort_by(&:created_at).reverse.paginate(page: params[:page], :per_page => 7)
    @content = load_commentable
    render :layout => "application2"
  end

  def like
    @user = current_user
    @comment = Comment.find(params[:id])
    @user.likes @comment
    @commentable = @comment.commentable
    redirect_to @commentable
  end

  def dislike
    @user = current_user
    @comment = Comment.find(params[:id])
    @user.dislikes @comment
    @commentable = @comment.commentable
    redirect_to @commentable
  end

  def new
    @comment = @commentable.comments.new
  end 

  def show
    @content = load_commentable
    @comments = @content.comments #.paginate(:page => params[:page])
    #@title = @user.username
  end

  def reply
    @content = load_commentable
    render :layout => "application2"
  end

  def create
    #@content = Content.find(params[:content_id])
    #@comment = @content.comments.build(params[:comment])
    #@comment = current_user.contents.build(params[:content])
    @commentable = load_commentable
    @comment = @commentable.comments.build(params[:comment])
    @comment.user = current_user
    @commentable.content_changed_at = @comment.created_at
    #@comment.content_id = @content.id

    if @comment.save
      redirect_to @commentable, :flash => { :success => "comment created!" }
    else
      redirect_to root_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    #@content = load_commentable
    #@comment = @content.comments.find(params[:id])
    #@comment.destroy
    redirect_to root_path, :flash => { :success => "comment deleted!" }
  end

  def load_commentable
      if params[:content_id]
        @commentable = Content.find(params[:content_id])
      elsif params[:photo_id]
        @commentable = Photo.find(params[:photo_id])
      end
  end
  
  private
  
    def authorized_user
      if current_user.admin?
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to root_path, :flash => { :success => "content deleted!" }
      else
        @comment = current_user.comments.find_by_id(params[:id])
        redirect_to root_path if @comment.nil?
      end
    end

    #def load_commentable
    #  resource, id = request.path.split('/')[1, 2]
    #  @commentable = resource.singularize.classify.constantize.find(id)
    #end

end