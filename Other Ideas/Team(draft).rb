class Team < ActiveRecord::Base
    has_many :season_teams
    has_many :seasons, through: :season_teams
    has_many :players
    belongs_to :league
    has_many :home_match, class_name: 'Match'
    has_many :away_match, class_name: 'Match'

    def self.paid
        Team.all.select {|t| t.fee_paid? == true}
    end

    def self.no_payment
        Team.all.select {|t| t.fee_paid? == false}
    end

end