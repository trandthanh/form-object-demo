class TeamForm < Reform::Form
  property :name
  property :coach
  property :nationality

  validates :name, presence: true
  validates :coach, presence: true
  validates :nationality, inclusion: { in: %w(FR ENG), message: "%{value} is not a valid nationality" }

  collection :players, populate_if_empty: Player do
    property :first_name
    property :last_name
    property :nationality
    property :age
    property :height
    property :weight
    property :position
    property :priority

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :nationality, inclusion: { in: %w(FR ENG), message: "%{value} is not a valid nationality" }

    validate :fr_citizen?

    def fr_citizen?
      errors.add(:nationality, "The player is not a FR player") if nationality != team.nationality
    end
  end
end
