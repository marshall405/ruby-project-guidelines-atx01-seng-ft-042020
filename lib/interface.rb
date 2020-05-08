require 'colorize'
require 'pry'
class UserInterface 
    # Interacts with user via command line
    @@user = nil

    extend Views
    extend Commands 

    def self.get_user_input
        gets.strip.chomp
    end

    def self.stopper
        space
        print "Press return to see main menu.".green.on_black

        input = get_user_input

        if input
            command_prompt
        end
    end
    


    def self.start
        greeting
        login_or_create_account
    end

    def self.login_or_create_account
        login_or_create_view
        space(3)
        loop do 
            print "What would you like to do? [Enter number]: ".green.on_black
            space(1)
            action = get_user_input
            case action
            when "1"
                login
                break
            when "2"
                create_account
                break
            when "3"
                exit_program
                break
            else
                print "Please enter valid action\n".red.on_black
                space(1)
            end
        end
    end

    def self.create_account
        create_view 
        loop do 
            print "Enter a username: ".green.on_black
            space(1)

            username = get_user_input
            while username.empty?
                print "Username cannot be empty: ".green.on_black
                space(1)

                username = get_user_input
            end
            user = User.find_by(username: username)
            if !user 
                @@user = User.create(username: username)
                welcome_user(@@user.username)
                command_prompt
                break
            else
                print "#{username} is already taken!\n".red.on_black
            end
        end
    end

    def self.login
        login_view 
        loop do 
            print "Enter your username:".green.on_black
            space(1)
            username = get_user_input
            while username.empty?
                print "Enter a username or type 'back'".red.on_black
                space(1)
                username = get_user_input
        
            end
            if username == 'back'
                command_prompt
                break
            end
            
            user = User.login(username)
            if user 
                @@user = user
                welcome_user(user.username)
                stopper
                break
            else
                print "Could not find username '#{username}'\n".red.on_black
            end
        end
    end

    def self.command_prompt
        command_prompt_view
        print "What action would you like to take?".green.on_black
        space(1)
        action = get_user_input
        case action
        when "1"
            repo_actions
        when "2"
            edit_user
        when "3"
            exit_program
        else 
            print "Please select a valid action".red.on_black
            command_prompt
        end
    end

    def self.edit_user
        user_view
        loop do 
            print "What would you like to change about this user?".green.on_black
            space(1)
            action = get_user_input
            while action.empty?
                print "Please select a valid action\n".red.on_black
                print "What would you like to change about this user?".green.on_black
                action = get_user_input
            end
            case action
            when "1"
                update_username
                break
            when "2"
                user_delete_user
                break
            when "3"
                command_prompt
                break
            else
                print "Please select a valid action\n".red.on_black
            end
        end
    end

    def self.repo_stopper
        space(4)
        print "Press return to go back to Repo Action menu.".green.on_black
        get_user_input
        repo_actions
    end

    def self.repo_actions
        repo_view
        loop do 
            print "Please choose a repo action.".green.on_black
            space(1)
            action = get_user_input
            while action.empty?
                print "Please enter a valid repo action.\n".red.on_black
                print "Please choose a repo action.".green.on_black
                space(1)
                action = get_user_input
            end
            case action
            when "1"
                search_repos
                break
            when "2"
                list_user_repos
                break
            when "3"
                search_user_repos_by_keyword
                break
            when "4"
                delete_user_repo
                break
            when "5"
                command_prompt
                break
            else
                print "Please enter a valid repo action.\n".red.on_black
                
            end
        end
    end


    def self.search_repos
        print "Enter keyword to search: [ex: React], or type 'back'.".green.on_black
        space(1)
        keyword = get_user_input
        while keyword.empty?
            print "Cannot be empty.\n".red.on_black
            print "Enter keyword to search: [ex: React], or type 'back'.".green.on_black
            space(1)
            keyword = get_user_input
        end
        if keyword == "back"
            repo_actions
        else 
            space(40)
            Repo.search(keyword)
            user_save_repo
            repo_actions
        end
    end

    def self.list_user_repos
        space(40)
        if @@user.user_repos_count > 0
            @@user.display_repos_by_user
        else 
            print "No repos saved!".green.on_black
        end
        repo_stopper
    end

    def self.search_user_repos_by_keyword
        space
        if @@user.user_repos_count > 0        
            print "Enter keyword to search: [ex: React], or type 'back'.".green.on_black
            space(1)

            keyword = get_user_input
            if keyword == "back"
                repo_actions
            elsif keyword != ""
                saved = @@user.get_repos_by_keyword(keyword)
                if saved.empty?
                    space
                    print "No Repos with that keyword".green.on_black
                end
                space
                print "Press return to go back to Repo Action menu.".green.on_black
                space(1)
                get_user_input
                repo_actions
            else
                space(4)
                print "Invalid Input, going back to Repo Action menu".green.on_black
                repo_stopper
            end
        else
            print "No repos saved!".green.on_black
            repo_stopper
        end
    end

    def self.delete_user_repo
        if  @@user.user_repos_count > 0
            space(10)
            @@user.display_repos_by_user
            space(2)
            loop do 
                print "Enter a Repo ID, type '***' to delete all repos or type 'back' to exit.".green.on_black
                space(1)
                id = get_user_input
                while id.empty?
                    print "Cannot be empty.\n".red.on_black
                    print "Enter a Repo ID, type '***' to delete all repos or type 'back' to exit.".green.on_black
                    space(1)
                    id = get_user_input
                end
                if id == 'back'
                    repo_actions
                    break
                elsif id == '***'
                    user_delete_all_user_repos
                    repo_stopper
                    break
                else 
                    if @@user.valid_repo_id(id)
                        case id 
                        when 'back'
                            repo_actions
                            break
                        when '***'
                            user_delete_all_user_repos
                            break 
                        else
                            print "Are you sure? (y)".red.on_black
                            space(1)
                            input = get_user_input
                            if input.downcase == 'y'
                                repo = @@user.delete_repo(id.to_i - 1)
                                print "\n#{repo.name} has been deleted.\n".green.on_black
                                repo_stopper
                            else
                                print "No repos have been deleted.".green.on_black
                                repo_stopper
                            end
                            break
                        end
                    else
                        print "Invalid repo ID\n".red.on_black
                    end
                end
            end
        else 
            space(3)
            print "No repos to delete!".green.on_black
            repo_stopper
        end 
    end

    # def self.user_delete_single_user_repo(id)
    #     space(1)
    #     print "Are you sure? (y / n)".green.on_black
    #     input = get_user_input
    #     space(1)
    #     if input.downcase == 'y'
    #         @@user.delete_repo(id.to_i - 1)
    #     elsif input.downcase == 'n'
    #         print "No repo deleted.".green.on_black
    #     end
    # end

    def self.user_delete_all_user_repos
        print "Are you sure you want to delete ALL of your repos? (y)?".red.on_black
        space(1)
        input = get_user_input
        if input.downcase == 'y'
            @@user.delete_all_user_repos 
            space(1)
            print "All repos have been deleted.".green.on_black
        else
            space(1)
            print "No repos were deleted.".green.on_black
        end
    end

    def self.update_username
        space
        loop do 
            print "Current username: #{@@user.username}\n".green.on_black
            print "Enter new username or type 'back'".green.on_black
            space(1)
            new_username = get_user_input
            while new_username.empty?
                print "Cannot be empty.\n".red.on_black
                print "Enter new username or type 'back'".green.on_black
                space(1)
                new_username = get_user_input
            end

            does_username_exist = User.find_by(username: new_username)
            if new_username == "back"
                command_prompt
                break
            elsif new_username != @@user.username && !does_username_exist
                print "***************\n".green.on_black
                print @@user.update_username(new_username).green.on_black
                print "\n***************".green.on_black
                @@user = User.find(@@user.id)
                stopper
                break
            else 
                space
                print "Enter valid name\n".red.on_black
            end
        end
    end

    def self.user_delete_user
        space(5)
        print "Delete user: #{@@user.username}.\n\n\nAre you sure? (y / n)".green.on_black
        space(1)
        input = get_user_input
        while input != 'y' && input != 'n'
            space(4)
            print "Please enter a valid command.".green.on_black
            space(1)
            input = get_user_input
        end 
        if input.downcase == "y"
            space(4)
            print "Goodbye forever, #{@@user.username}.\n\n\nLogin to or create a different user.\n\n\nReturning to start menu.".green.on_black
            @@user.delete_user
            login_or_create_account
        else input.downcase == "n"
            space(4)
            print "No users deleted.\n\n\nReturning to edit user menu.".green.on_black
            edit_user
        end
    end


    def self.user_save_repo
        space
        print "
               Would you like to save a repo(y)?\n
               Everything not saved will be lost!".green.on_black
        space(1)

        input = get_user_input
        while input.downcase == 'y'
            save_repo
            print "Would you like to save a repo(y)?\n".green.on_black
            space(1)
            input = get_user_input
        end
        repo_actions
    end

    def self.save_repo
        space(1)
        print "Enter the Repo ID, or type 'back'".green.on_black
        space(1)

        id = get_user_input
        while id.empty?
            print "Must enter the Repo ID, or type 'back'".red.on_black
            space(1)

            id = get_user_input
        end 

        count = Repo.searched_repos.count 
        if id.downcase == 'back'
            return
        else 
            while id.to_i <= 0 || id.to_i > count do
                print "Repo ID must be between 1 and #{count}, or type 'back'.".red.on_black
                space(1)
                id = get_user_input
                if id.downcase == "back"
                    return
                end
            end
            repo = Repo.searched_repos[id.to_i - 1]
            already_saved = @@user.check_for_saved_repo(repo)
            if already_saved
                space
                print "#{repo.name} already saved\n!".green.on_black
            else
                UserRepo.create(@@user, repo)
                space
                print "#{repo.name} saved!\n".green.on_black
            end
        end
    end

    def self.exit_program
        exit_program_view
        exit 
    end

    private
    def self.space(n=2)
        n.times do 
            print "\n".green.on_black
        end
    end
    

end
 
#1. Add to menu "Search user repo by keyword" using include
#2. Look into TTY and other project requirements
