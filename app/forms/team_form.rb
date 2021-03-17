class TeamForm
  include ActiveModel::Model

  attr_accessor :name, :coach, :nationality, :players

  def initialize(attributes = {})
    @team = Team.new
    @players ||= []
    @players << @team.players.build
    @players << @team.players.build
    # ...
    super
  end

  validates :name, presence: true
  validates :coach, presence: true
  validates :nationality, inclusion: { in: %w(french british vietnamese chinese russian martian austrian german scottish columbian breton american polish lebanese), message: "%{value} is not a valid nationality" }

  validate :citizen?

  # accepted_nested_attributes_for :players
  def players_attributes=(attributes)
    attributes.each do |i, player_params|
      @players[i.to_i].assign_attributes(player_params)
    end
  end

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      team = Team.create!(name: name, coach: coach, nationality: nationality)
      @players.each do |player|
        player.team = team
        player.save!
      end
    end
  end


  private

  def citizen?
    @players.each do |player|
      errors.add(:player, "This player has to be #{nationality}") if player.nationality != nationality
    end
  end
end
