class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :dob
      t.integer :jersey_number
      t.string :jersey_size
      t.integer :team_id
    end
  end
end
