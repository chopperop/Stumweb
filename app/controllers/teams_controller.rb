class TeamsController < ApplicationController
  def index
    @title = "All teams"
    @teams = Team.all.sort_by(&:team_score).reverse.paginate(page: params[:page], :per_page => 30)
  end

  def show
    @team = Team.find(params[:id])
    @title = @Team.team_name
  end

  def new
    @team = Team.new
    @title = "Create a team"
  end

  def create
    @user = current_user
    @team = current_user.build_team(params[:team])

    if @team.save 
      sign_in @user
      redirect_to root_path, :flash => { :success => "You have created a team!" }
    else
      @title = "Create a team"
      render 'new' 
    end
  end

  def join
    @join = Project.search(params[:search])
    redirect_to @user
  end

  def edit
  end

  def update
  end

  def destroy
    @Team.destroy
    redirect_to root_path, :flash => { :success => "Team destroyed." }
  end

end
