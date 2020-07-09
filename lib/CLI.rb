def run
    while true do
    greet
    log_in
    end
end


def greet
    puts " #     #                                                           "
    puts " #  #  # ###### #       ####   ####  #    # ######    #####  ####  "
    puts " #  #  # #      #      #    # #    # ##  ## #           #   #    # "
    puts " #  #  # #####  #      #      #    # # ## # #####       #   #    # "
    puts " #  #  # #      #      #      #    # #    # #           #   #    # "
    puts " #  #  # #      #      #    # #    # #    # #           #   #    # "
    puts "  ## ##  ###### ######  ####   ####  #    # ######      #    ####  "
                                                                      
    puts " #                                          "
    puts " #       ######   ##    ####  #    # ###### "
    puts " #       #       #  #  #    # #    # #      "
    puts " #       #####  #    # #      #    # #####  "
    puts " #       #      ###### #  ### #    # #      "
    puts " #       #      #    # #    # #    # #      "
    puts " ####### ###### #    #  ####   ####  ###### "
                                               
    puts "  #####                                                     "
    puts " #     # #####   ####    ##   #    # # ###### ###### #####  "
    puts " #     # #    # #    #  #  #  ##   # #     #  #      #    # "
    puts " #     # #    # #      #    # # #  # #    #   #####  #    # "
    puts " #     # #####  #  ### ###### #  # # #   #    #      #####  "
    puts " #     # #   #  #    # #    # #   ## #  #     #      #   #  "
    puts "  #####  #    #  ####  #    # #    # # ###### ###### #    # "
end


def exit_app
    puts "Goodbye!!"
    exit
end


def log_in
    puts "---------------------------------"
    puts "1. Sign in to an existing account"
    puts "2. Create a new account."
    puts "Type in 'exit' to quit"
    response = gets.chomp.capitalize
    if response == 'Exit'
        exit_app
    elsif response == '1'
        choice = response.to_i
        case
        when 1
            puts "---------------------------------"
            puts "Please Enter your login id"
            id = gets.chomp
            puts "---------------------------------"
            puts "please Enter your password"
            pw = gets.chomp
            user_authorization(id, pw)
        end
    elsif '2'
        create_user
    else
        puts "---------------------------------"
        puts 'Invalid entry, please try again'
        log_in
    end
end


def user_authorization(id, pw)
    user = User.all.select {|i| i.user_id.upcase == id.upcase}.first
    if user.password == pw
        puts "---------------------------------"
        puts "Welcome #{user.user_id}!"
        prompt(user)
    else
        puts "---------------------------------"
        puts "Sorry, we couldn't find the matching entry."
        puts "Please try again."
        log_in
    end
end


def create_user
    puts "---------------------------------"
    puts "What is your first name?"
    first_name = gets.chomp.capitalize
    puts "---------------------------------"
    puts "What is your last name?"
    last_name = gets.chomp.capitalize
    create_user_name_and_password(first_name, last_name)
end
    


def create_user_name_and_password(first_name, last_name)
    puts "---------------------------------"
    puts "9. to exit program"
    puts "0. to go back to login page"
    puts "Choose your user name, must be more than 4 characters"
    response = gets.chomp
        if User.all.exists?(response) == true
            puts "Sorry, that user name already exists, try another one"
            create_user_name_and_password
        elsif User.all.exists?(response) == false && response.length > 4
            user_name = response
            puts "---------------------------------"
            puts "Choose your password, it is case sesitive"
            password = gets.chomp
            User.create(first_name: first_name, last_name: last_name, user_id: user_name, password: password)
            puts "---------------------------------"
            puts "Thank you #{first_name}, You've created an account"
            puts "Username: #{user_name}"
            puts "Password: #{password}"
            log_in
        elsif response == '9'
            exit_app
        else response == '0'
            log_in
        end
end
      

def prompt(user)
    puts "---------------------------------#{user.user_id}"
    puts "Choose your option."
    puts "1. Manage League"
    puts "2. Create New League"
    puts "3. Delete a League"
    puts "0. Sign Out"
    puts "You can type in 'exit' to quit any time"
    puts "---------------------------------"
    response = gets.chomp.capitalize
    if response == 'Exit'
        exit_app
    elsif response =='0'
        log_in
    else
        choice = response.to_i
        case choice
        when 0
            exit_app
        when 1
            league_search(user)
        when 2
            create_new_league(user)
        when 3
            delete_league(user)
        end
    end
end


def league_search(user)
    puts "---------------------------------#{user.user_id}"
    puts "Which league do you want to manage."
    puts "Choose the corresponding number."
    puts user.league_list
    puts "0. Go back to the previous option"
    puts "---------------------------------"
    response = gets.chomp.capitalize
    if response == 'Exit'
        exit_app
    else
        choice = response.to_i
        case choice
        when 0
            prompt(user)
        when (1..)
            choice -= 1
            t = user.league_list[choice].split(" ").drop(1).join(' ')
            league = user.leagues.find_by(name: t)
            options(user,league)
        else
            puts 'That was a invalid option, try again.'
            league_search(user)
        end
    end
end


def options(user,league) #choose user's action
    puts "---------------------------------#{user.user_id}"
    puts "What would you like to do?       #{league.name}"     
    puts "Choose the corresponding number."
    puts "1. Manage Seasons"
    puts "2. Manage Teams"
    puts "3. Manage Players"
    puts "4. Create a Season"
    puts "5. Delete a Season"
    puts "0. Go back to the previous option"
    puts "---------------------------------"
    response = gets.chomp.capitalize
    if response == 'Exit'
        exit_app
    else
        choice = response.to_i
        case choice
        when 1
            season_manager(user,league)
        when 2
            team_manager(user,league)
        when 3
            player_manager(user,league)
        when 4
            create_new_season(user,league)
        when 5
            delete_season(user,league)
        when 0
            league_search(user)
        else
            puts 'That was a invalid option, try again.'
            options(user,league)
        end
    end
end

def create_new_league(user)
    puts "---------------------------------#{user.user_id}"
    puts "0. Go back to the previous option"
    puts "Enter a name for your league!"
    puts "---------------------------------"
    response = gets.chomp
    if response.casecmp("exit") == 0
        exit_app
    elsif response == "0"
        prompt(user)
    else
        if user.leagues.all.exists?(name: response)
            puts "---------------------------------"
            puts "League named #{response} already exists in your account"
            puts "Please, try a different name."
            create_new_league(user)
        else
            confirm_league_name(user,response)
        end
    end
end


def confirm_league_name(user,response)
    puts "---------------------------------#{user.user_id}"
    puts "Your league name will be #{response}"
    puts "Would you like to create this league? (Y/N)"
    puts "---------------------------------"
    choice = gets.chomp.capitalize
            if choice == "Y" || choice == "Yes" || choice == "N" || choice == "No"
                if choice == "Y" || choice == "Yes"
                    League.create(name: response, user: user)
                    puts "---------------------------------"    
                    puts "Congratulations! You've created a new league!"
                    puts "Your league name #{response}."
                    puts "You may now manage your league '#{response}'! "
                    puts "---------------------------------"
                    prompt(user)
                else choice == "N" || choice == "No"
                    create_new_league(user)
                end
            elsif choice =='Exit'
                exit_app
            else
                puts "---------------------------------"  
                puts "Invalid entry try again."
                puts "---------------------------------" 
                confirm_league_name(response)
            end
end
            

def delete_league(user)
    puts "---------------------------------#{user.user_id}"
    puts "Which league would you like to delete?"
    puts "Choose the corresponding number."
    puts user.league_list
    puts "0. Go back to the previous option"
    puts "---------------------------------"
    response = gets.chomp.capitalize
    if response == 'Exit'
        exit_app
    else
        choice = response.to_i
        case choice
        when (1..)
            choice -= 1
            confirm_delete_league(user,choice)
        when 0
            prompt(user)
        end
    end
end


def confirm_delete_league(user,choice)
    t = user.league_list[choice].split(" ").drop(1).join(' ')
    league = user.leagues.find_by(name: t)
    puts "---------------------------------"
    puts "Are you sure you want to delete #{t}? (Y/N)"
    puts "---------------------------------"
    choice = gets.chomp.capitalize
        if choice == "Y" || choice == "Yes" || choice == "N" || choice == "No"
            if choice == "Y" || choice == "Yes"
                League.destroy(league.id)
                puts "---------------------------------"    
                puts "You have deleted #{t}"
                puts "---------------------------------"
                prompt(user)
            else choice == "N" || choice == "No"
                delete_league(user)
            end
        elsif choice =='Exit'
            exit_app
        else
            puts "---------------------------------"  
                puts "Invalid entry try again."
                puts "---------------------------------"
            confirm_delete_league(user,choice)
        end
end


def season_manager(user,league)
    puts "---------------------------------"
    puts "Choose the number of the season you want to manage."
    puts league.season_list
    puts "0. Go back to the previous option"
    puts "---------------------------------"
    response = gets.chomp.capitalize
    if response == 'Exit'
        exit_app
    else
        choice = response.to_i
        case choice
        when (1..)
            choice -= 1
            t = league.season_list[choice].split(" ").drop(1)
            season = league.seasons.find_by(year: t[0], which_season: t[1])
            season_option(user,league,season)
        when 0
            options(user,league)
        end
    end 
end


def season_option(user,league,season)
    puts "---------------------------------#{user.user_id}"
    puts "What would you like to do?       #{league.name}, #{season.year}, #{season.which_season}"
    puts "Choose the corresponding number."
    puts "1. Season Standings"
    puts "0. Go back to the previous option"
    puts "---------------------------------"
    response = gets.chomp.capitalize
    if response == 'Exit'
        exit_app
    else
        choice = response.to_i
        case choice
        when 1
            puts "---------------------------------"
            puts season.standing
            season_option(user,league,season)
        when 0
            options(user,league)
        else
            puts "#{choice} is an invalid entry try again"
            puts "---------------------------------"
            season_option(user,league,season)
        end
    end
end


def create_new_season(user, league)
    puts "---------------------------------#{user.user_id}"
    puts "Enter a year for your season!    #{league.name}"
    puts "---------------------------------"
    year = gets.chomp.capitalize
    if year != "Exit"
        year.to_i
        puts "---------------------------------"
        puts "Enter a season for your seaons"
        puts "Ex: 'Spring', 'Summer', 'Fall', 'Winter' "
        puts "---------------------------------"
        season = gets.chomp.capitalize
        if season != "Exit"
            if season == "Spring" || season == "Summer" || season == "Fall" || season == "Winter"
                if league.seasons.all.exists?(year: year, which_season: season) == true
                    puts "---------------------------------"
                    puts "This #{year}, #{season} already exists."
                    puts "Please try again."
                    create_new_season(user,league)
                else
                    Season.create(year: year, which_season: season, league: league)
                    puts "---------------------------------"
                    puts "You've created a new season '#{year}, #{season}' in the #{league.name}"
                    options(user,league)
                end
            else
                puts "Invalid entry, please try again"
                create_new_season(user,league)
            end
        else
            exit_app
        end
    else
        exit_app
    end
end


def delete_season(user,league)
    puts "---------------------------------#{league.name}"
    puts "Which season would you like to delete?"
    puts "Choose the corresponding number."
    puts league.season_list
    puts "0. Go back to the previous option"
    puts "---------------------------------"
    response = gets.chomp.capitalize
    if response == 'Exit'
        exit_app
    else
        choice = response.to_i
        case choice
        when (1..)
            choice -= 1
            confirm_delete_season(user,choice,league)            
        when 0
            options(user,league)
        end
    end
end

def confirm_delete_season(user,choice,league)
    t = league.season_list[choice].split(" ").drop(1)
    season = league.seasons.find_by(year: t[0], which_season: t[1])
    puts "---------------------------------"
    puts "Are you sure you want to delete season: '#{season.year}, #{season.which_season}'? (Y/N)"
    puts "---------------------------------"
    choice = gets.chomp.capitalize
        if choice == "Y" || choice == "Yes" || choice == "N" || choice == "No"
            if choice == "Y" || choice == "Yes"
                season.destroy
                puts "---------------------------------"    
                puts "You have deleted #{t}"
                options(user,league)
            elsif choice == "N" || choice == "No"
                delete_season(user,league)
            end
        elsif choice =='Exit'
            exit_app
        else
            puts "---------------------------------"  
            puts "Invalid entry try again."
            delete_season(user,league)
        end
end


def team_manager(user, league)
    puts "---------------------------------#{user.user_id}"
    puts "Choose the corresponding number. #{league.name}"
    puts "1. List of all teams"
    puts "2. Team's fee status"
    puts "3. Update team fee status"
    puts "0. Go back to the previous option"
    puts "---------------------------------"
    response = gets.chomp.capitalize
    if response == 'Exit'
        exit_app
    else
        choice = response.to_i
        case choice
        when 1
            puts "---------------------------------"
            puts league.team_list
            team_manager(user,league)
        when 2
            puts "---------------------------------"
            puts league.team_payment_status
            team_manager(user,league)
        when 3
            puts "---------------------------------"
            puts "Which team's payment status would you like to update?"
            puts "Choose the corresponding number."
            puts league.team_list
            puts "0. Go back to the previous option"
            puts "---------------------------------"
            response = gets.chomp.capitalize
            if response == 'Exit'
                exit_app
            elsif response == '0'
                team_manager(user, league)
            else
                choice = response.to_i - 1
                t = league.team_list[choice].split(" ").drop(1).join(' ')
                if league.teams.exists?(team_name: t)
                    team = league.teams.find_by(team_name: t)
                    puts "---------------------------------"
                    puts "fee_paid?: #{team.fee_paid?}"
                    puts "Did you receive their payment? (Y/N)"
                    input = gets.chomp.upcase
                    case input
                    when 'Y'
                        team.update(fee_paid?: true)
                        puts "---------------------------------"
                        puts "You've accepted payment from #{team.team_name}."
                        team_manager(user,league)
                    when 'N'
                        team.update(fee_paid?: false)
                        puts "---------------------------------"
                        puts "You've rejected payment from #{team.team_name}."
                        team_manager(user,league)
                    end
                else
                    "Your input is not valid, try again."
                    team_manager(user,league)
                end
            end
        when 0
            options(user,league)
        end
    end
end


def player_manager(user,league)
    puts "---------------------------------#{league.name}"
    puts "Type in player's first name and first letter of their last name"
    puts "Ex: 'Kobe B' | 'Michael J' | 'Lebron J'"
    puts "0. Go back to the previous option"
    puts "---------------------------------"
    response = gets.chomp.capitalize
    if response == 'Exit'
        exit_app
    else
        n = response.split(" ").map(&:capitalize)
        if  league.players.exists?(first_name: n[0], last_name: n[1])
            player = league.players.find_by(first_name: n[0], last_name: n[1])
            puts "Found your player named #{n[0]}, #{n[1]}."
            player_option(user,league,player)
        elsif n[0] == "0"
            options(user, league)
        else
            puts "Could not find the player, please try again."
            player_manager(user,league)
        end
    end
end

            
def player_option(user,league,player)
    puts "---------------------------------"
    puts "Choose your option.                 #{player.first_name}, #{player.last_name}"
    puts "1. Player's Jersey Number           #{player.team.team_name}"
    puts "2. Player's Jersey Size"
    puts "3. Date of Birth"
    puts "0. Go back to the previous option"
    puts "---------------------------------"
    response = gets.chomp.capitalize
    if response == 'Exit'
        exit_app
    else
        choice = response.to_i
        case choice
        when 1
            puts "---------------------------------"
            puts player.jersey_number
            player_option(user,league,player)
        when 2
            puts "---------------------------------"
            puts player.jersey_size
            player_option(user,league,player)
        when 3
            puts "---------------------------------"
            puts player.dob
            player_option(user,league,player)
        when 0
            player_manager(user,league)
        end
    end
end

