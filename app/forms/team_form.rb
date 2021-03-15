class TeamForm < Reform::Form
  property :name
  property :coach
  property :nationality

  validates :name, presence: true
  validates :coach, presence: true
  validates :nationality, presence: true

  collection :players, populate_if_empty: Player do
    property :first_name
    property :last_name
    property :nationality
    property :age
    property :height
    property :weight
    property :position
    property :priority # default

    validates :first_name, presence: true
    validates :last_name, presence: true

    # validate :citizen? do
    #   errors.add(:nationality, "The player has to be a #{form.team.team_nationality} player") if form.team.nationality == nationality
    # end
  end
end
