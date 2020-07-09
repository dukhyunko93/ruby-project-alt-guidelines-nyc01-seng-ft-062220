class SeasonTeam < ActiveRecord::Base
    belongs_to :season
    belongs_to :team
end
