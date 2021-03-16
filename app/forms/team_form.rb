class TeamForm
  include ActiveModel::Model

  attr_accessor :name, :coach, :nationality, :players

  validates :name, presence: true
  validates :coach, presence: true
  validates :nationality, inclusion: { in: %w(FR ENG), message: "%{value} is not a valid nationality" }

  validate :citizen

  def citizen
    players.each do |player_form|
      raise
      errors.add(:player, "Player must be #{nationality}") unless player_form.valid?
    end
  end

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      raise
      user = Team.create!(name: name, coach: coach, nationality: nationality)
    end

    true # return true if the model is saved
  end
end
