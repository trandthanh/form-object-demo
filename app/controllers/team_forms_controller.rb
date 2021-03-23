class TeamFormsController < ApplicationController
  def new
    @form = TeamForm.new(players: [Player.new, Player.new])
  end

  def create
    @form = TeamForm.new(team_form_params)
    if @form.save
      redirect_to teams_path
    else
      render :new
    end
  end

  private

  def team_form_params
    params.require(:team_form).permit(:name, :coach, :nationality, {players_attributes: [:first_name, :last_name, :nationality]})
  end
end
