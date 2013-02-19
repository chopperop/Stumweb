class UsersController < ApplicationController
  before_filter :authenticate,
                :only => [:edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  
  def index
    @users = User.paginate(:page => params[:page])
    @title = "All users"
  end
  
  def show
    @user = User.find(params[:id])
    @contents = @user.contents #.paginate(:page => params[:page])
    @photos = @user.photos #.paginate(:page => params[:page])
    @everything = (@contents + @photos).sort_by(&:content_changed_at).reverse.paginate(page: params[:page], :per_page => 5)
    @title = @user.username
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.find_liked_items.reverse.paginate(page: params[:page], :per_page => 5)
  end

  def dislikes
    @user = User.find(params[:id])
    @dislikes = @user.find_disliked_items.reverse.paginate(page: params[:page], :per_page => 5)
  end

  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to @user, :flash => { :success => "Welcome to the Sample App!" }
    else
      @title = "Sign up"
      render 'new' 
    end
  end

  def new_message
    @message = ActsAsMessageable::Message.new
  end

  def create_message
    @to = User.find_by_username(params[:message][:to])
    current_user.send_message(@to, params[:message][:body])
    redirect_to @user
  end
  
  def destroy_message
    @message = current_user.messages.find(params[:id])
    @message.destroy
    redirect_to inbox_user_path(current_user)
  end

  def messages
    @messages = current_user.messages
  end

  def inbox
    @messages = current_user.received_messages.sort_by(&:created_at).reverse.paginate(page: params[:page], :per_page => 5)
  end

  def outbox
    @messages = current_user.sent_messages
  end


  def show_message
    @message = current_user.messages.find(params[:id])
  end

  def edit
    @title = "Edit user"
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      sign_in @user
      redirect_to @user, :flash => { :success => "Profile updated." }
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, :flash => { :success => "User destroyed." }
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end