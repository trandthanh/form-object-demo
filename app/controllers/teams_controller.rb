class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def new
    # team = Team.new
    # team.players.build
    # @form = TeamForm.new(team)
    @form = TeamForm.new(players: [Player.new, Player.new])
  end

  def create
    @form = TeamForm.new(team_form_params)
    if @form.save
      redirect_to teams_path
    else
      render :new
    end
    # team = Team.new
    # @form = TeamForm.new(team)

    # if @form.validate(team_params)
    #   @form.save
    #   redirect_to teams_path
    # else
    #   render :new
    # end
  end

  private

  def team_form_params
    params.require(:team_form).permit(:name, :coach, :nationality, players_attributes: [:_destroy, :id, :first_name, :last_name, :nationality])
  end
end
