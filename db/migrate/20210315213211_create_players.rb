class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :nationality
      t.integer :age
      t.integer :height
      t.integer :weight
      t.string :position
      t.string :priority
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
