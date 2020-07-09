class CreateSeasonTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :season_teams do |t|
      t.integer :season_id
      t.integer :team_id
    end
  end
end
