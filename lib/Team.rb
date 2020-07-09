class Team < ActiveRecord::Base
    has_many :season_teams
    has_many :seasons, through: :season_teams
    has_many :players
    belongs_to :league
    has_one :record

end
