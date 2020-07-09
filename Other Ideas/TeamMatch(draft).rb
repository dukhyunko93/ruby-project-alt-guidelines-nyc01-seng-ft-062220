class TeamMatch < ActiveRecord::Base
    belongs_to :team_home, :class_name => :Team
    belongs_to :team_away, :class_name => :Team
    belongs_to :match
end
