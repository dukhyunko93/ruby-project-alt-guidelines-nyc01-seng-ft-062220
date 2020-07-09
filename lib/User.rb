class User < ActiveRecord::Base
    has_many :leagues

    def league_list
        counter = 0
        list = self.leagues.all.order('name')
        final_list = []
        until counter == self.leagues.all.count do
            final_list << "#{counter + 1}. #{self.leagues.find(list[counter].id).name}"
            counter += 1
        end
        final_list
    end
    
end
