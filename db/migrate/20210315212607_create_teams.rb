class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :coach
      t.string :nationality
      t.string :age_category

      t.timestamps
    end
  end
end
