class CreateTeamMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :team_matches do |t|
      t.integer :team_home_id
      t.integer :team_away_id
      t.integer :match_id
    end
  end
end
