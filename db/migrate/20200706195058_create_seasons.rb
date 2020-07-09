class CreateSeasons < ActiveRecord::Migration[5.2]
  def change
    create_table :seasons do |t|
      t.integer :year
      t.string :which_season
      t.integer :league_id
    end
  end
end
