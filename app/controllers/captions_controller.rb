class CaptionsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]
  before_filter :authorized_user, :only => :destroy

  def index
    @content = Content.find(params[:content_id])
    @captions = @content.captions #.paginate(:page => params[:page])
  end

  def show
    @content = Content.find(params[:content_id])
    @caption = @content.caption 
  end

  def new
  end

  def create
    @content = Content.new(params[:content])
    @captions = @content.captions.build(params[:caption])

    if @caption.save
      redirect_to root_path, :flash => { :success => "caption created!" }
    else
      @feed_items = content.all
      render 'pages/home2'
    end
  end

  def destroy
    #@caption.destroy
    @caption = current_user.captions.find(params[:id])
    #@content = content.find(params[:content_id])
    @caption.destroy
    redirect_to root_path, :flash => { :success => "caption deleted!" }
  end

  private
  
    def authorized_user
      @caption = current_user.captions.find_by_id(params[:id])
      redirect_to root_path if @caption.nil?
    end
end
