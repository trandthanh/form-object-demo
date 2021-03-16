class TeamForm
  include ActiveModel::Model

  attr_accessor :name, :coach, :nationality, :players

  validates :name, presence: true
  validates :coach, presence: true
  validates :nationality, inclusion: { in: %w(FR ENG), message: "%{value} is not a valid nationality" }

  validate :citizen

  # This method will be used in the form
  # remember that `fields_for :players_attributes` will ask for this method
  # comes in quite handy for me to use in the citizen validation
  def players_attributes=(attributes)
    @players ||= []
    attributes.each do |i, player_params|
      @players << Player.new(player_params)
    end
  end

  def citizen
    @players.each do |player_form|
      errors.add(:player, "Player must be #{nationality}") unless nationality == player_form.nationality
    end
  end

  def save
    return false if invalid?

    team = Team.create!(name: name, coach: coach, nationality: nationality)
    @players.each do |player|
      player.team = team
      player.save!(first_name: player.first_name, last_name: player.last_name, nationality: player.nationality)
    end

    true # return true if the model is saved
  end
end
