class League < ActiveRecord::Base
    belongs_to :user
    has_many :seasons
    has_many :teams, through: :seasons
    has_many :players, through: :teams
    
    def self.full_list
        counter = 0
        list = League.all.order('name')
        final_list = []
        until counter == League.all.count do
            final_list << "#{counter + 1}. #{League.all.find(list[counter].id).name}"
            counter += 1
        end
        final_list
    end

    
    def season_list
        counter = 0 
        list = self.seasons.order('year DESC')
        final_list = []
        until counter == self.seasons.count do
            final_list << "#{counter + 1}. #{seasons.find(list[counter].id).year}, #{seasons.find(list[counter].id).which_season}"
            counter += 1
        end
        final_list
    end


    def team_list
        counter = 0 
        list = self.teams.order('team_id')
        final_list = []
        until counter == self.teams.count do
        final_list << "#{counter + 1}. #{teams.find(list[counter].id).team_name}"
        counter += 1
        end
        final_list
    end


    def team_paid
        self.teams.all.select{|i| i.fee_paid? == true}.map{|i| i.team_name}
    end


    def team_not_paid
        self.teams.all.select{|i| i.fee_paid? == false}.map{|i| i.team_name}
    end


    def team_payment_status
        puts "Payment accepted: #{self.team_paid}."
        puts "---------------------------------"
        puts "Payment required: #{self.team_not_paid}."
    end

end