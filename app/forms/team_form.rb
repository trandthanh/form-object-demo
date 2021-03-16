class TeamForm
  include ActiveModel::Model

  attr_accessor :name, :coach, :nationality, :players

  validates :name, presence: true
  validates :coach, presence: true
  validates :nationality, inclusion: { in: %w(French British Vietnamese Chinese Russian Martian Austrian German Scottish Columbian Breton American Polish Lebanese), message: "%{value} is not a valid nationality" }

  validate :citizen

  # accepted_nested_attributes_for :players -> nested forms
  def players_attributes=(attributes)
    @players ||= []
    attributes.each do |i, player_params|
      @players << Player.new(player_params)
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

  def citizen
    @players.each do |player|
      errors.add(:player, "#{player.first_name} #{player.last_name} has to be #{nationality}") if player.nationality != nationality
    end
  end
end
