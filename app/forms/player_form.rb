class PlayerForm
  include ActiveModel::Model

  attr_accessor :first_name, :last_name, :nationality



  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      raise
      user = Team.create!(name: name, coach: coach, nationality: nationality)
    end

    true # return true if the model is saved
  end
end
