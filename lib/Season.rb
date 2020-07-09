class Season < ActiveRecord::Base
    belongs_to :league
    has_many :season_teams
    has_many :teams, through: :season_teams
    has_many :players, through: :teams
    has_many :records, through: :teams

    
    def standing
        counter = 0 
        ranking = self.records.order('win_total DESC', 'plus_mins_total DESC')
        list = []
        until counter == self.teams.count do
        list << "#{counter + 1}. #{self.teams.find(ranking[counter].team_id).team_name}"
        counter += 1
        end
        list
    end

end