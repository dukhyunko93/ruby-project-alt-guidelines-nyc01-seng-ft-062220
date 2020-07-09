class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.integer :team_id
      t.integer :win_total
      t.integer :loss_total
      t.integer :plus_mins_total
    end
  end
end
