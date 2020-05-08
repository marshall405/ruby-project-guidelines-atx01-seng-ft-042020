class UserInterface 
    # Interacts with user via command line
    @@user = nil

    extend Views
    extend Commands 

    def self.stopper
        space
        puts "Press return to go back to main menu."

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
        puts "What would you like to do? [Enter number]"
        action = get_user_input
        case action
        when "1"
            login
        when "2"
            create_account
        when "3"
            exit_program
        else
            "invalid input"
            login_or_create_account
        end
    end

    def self.get_user_input
        gets.strip.chomp
    end

    def self.create_account(message=nil)
        if message
            puts message
        end
        create_view 
        puts "Enter a username:"
        username = get_user_input
        self.create_account if username == ""
        user = User.find_by(username: username)
        if user
            create_account("#{username} is unavailable")
        end
        @@user = User.create(username: username)
        welcome_user(@@user.username)
        command_prompt
    end

    def self.login
        login_view 
        puts "Enter your username:"
        username = get_user_input
        user = User.login(username)
        if user 
            @@user = user
            welcome_user(user.username)
            stopper
        else
            could_not_find_user_view(username)
            login_or_create_account
        end
    end

    def self.command_prompt
        command_prompt_view
        puts "What action would you like to take?"
        action = get_user_input
        case action
        when "1"
            repo_actions
        when "2"
            edit_user
        when "3"
            exit_program
        else 
            puts "Please select a valid action"
            command_prompt
        end
    end

    def self.edit_user
        user_view
        puts "What would you like to change about this user?"
        action = get_user_input
        case action
        when "1"
            update_username
        when "2"
            user_delete_user
        when "3"
            command_prompt
        else
            puts "Please select a valid action"
            edit_user
        end
    end

    def self.repo_stopper
        space(4)
        puts "Press return to go back to Repo Action menu."
        get_user_input
        repo_actions
    end

    def self.repo_actions
        repo_view
        puts "Please choose a repo action."
        action = get_user_input
        case action
        when "1"
            search_repos
        when "2"
            list_user_repos
        when "3"
            search_user_repos_by_keyword
        when "4"
            delete_user_repo
        when "5"
            command_prompt
        else
            space(4)
            puts "Please enter a valid repo action."
            repo_stopper
        end
    end


    def self.search_repos
        puts "Enter keyword to search: [ex: React], or type 'back'."
        keyword = get_user_input
        if keyword == "back"
            command_prompt
        elsif keyword != ""
            Repo.search(keyword)
            user_save_repo
        else
            search_repos
        end
    end

    def self.list_user_repos
        @@user.display_repos_by_user
        stopper
    end

    def self.search_user_repos_by_keyword
        space
        puts "Enter keyword to search: [ex: React], or type 'back'."
        keyword = get_user_input
        if keyword == "back"
            repo_actions
        elsif keyword != ""
            saved = @@user.get_repos_by_keyword(keyword)
            if saved.empty?
                space
                puts "No Repos with that keyword"
            end
            space
            puts "Press return to go back to Repo Action menu."
            get_user_input
            repo_actions
        else
            space(4)
            puts "Invalid Input, going back to Repo Action menu"
            repo_stopper
        end
    end

    def self.delete_user_repo
        if  @@user.user_repos_count > 0
            space(10)
            @@user.display_repos_by_user
            space(1)

            puts "Which Repo? Enter a Repo ID, type '***' to delete all repos or type 'back' to exit."
            id = get_user_input
            
            if id == 'back'
                command_prompt
            elsif id == '***'
                user_delete_all_user_repos
                stopper
            else 
                exit_loop = false
                delete_all = false
                while !@@user.valid_repo_id(id)
                    puts "Enter a valid Repo ID, type '***' to delete all repos or type 'back' to exit."
                    id = get_user_input
                    case id 
                    when 'back'
                        exit_loop = true
                        break
                    when '***'
                        delete_all = true
                        break 
                    end
                end
                space(1)
                if delete_all
                    user_delete_all_user_repos
                   
                    stopper
                elsif exit_loop
                    command_prompt
                else
                    puts @@user.delete_repo(id.to_i - 1)
                    stopper
                end
            end
        else 
            space(3)
            puts "No repos to delete!"
            stopper
        end 
    end

    def self.user_delete_single_user_repo(id)
        space(1)
        puts "Are you sure? (y / n)"
        input = get_user_input
        space(1)
        if input.downcase == 'y'
            @@user.delete_repo(id.to_i - 1)
        elsif input.downcase == 'n'
            puts "No repo deleted."
        end
    end

    def self.user_delete_all_user_repos
        puts "Are you sure you want to delete ALL of your repos? (y)?"
        input = get_user_input
        if input.downcase == 'y'
            @@user.delete_all_user_repos 
            space(1)
            puts "All repos have been deleted."
        else
            space(1)
            puts "No repos were deleted."
        end
    end

    def self.update_username
        space
        puts "Current username: #{@@user.username}"
        puts "Enter new username or type 'back'"
        new_username = get_user_input
        does_username_exist = User.find_by(username: new_username)
        if new_username == "back"
            command_prompt
        elsif new_username != "" && new_username != @@user.username && !does_username_exist
            puts "*" * 10
            puts @@user.update_username(new_username)
            puts "*" * 10
            @@user = User.find(@@user.id)
            stopper
        else 
            space
            puts "!" * 10
            puts "Enter valid name"
            puts "!" * 10
            
            self.update_username
        end
    end

    def self.user_delete_user
        space(5)
        puts "Delete user: #{@@user.username}.\n\n\nAre you sure? (y / n)" 
        input = get_user_input
        while input != 'y' && input != 'n'
            space(4)
            puts "Please enter a valid command."
            input = get_user_input
        end 
        if input.downcase == "y"
            space(4)
            puts "Goodbye forever, #{@@user.username}.\n\n\nLogin to or create a different user.\n\n\nReturning to start menu."
            @@user.delete_user
            login_or_create_account
        else input.downcase == "n"
            space(4)
            puts "No users deleted.\n\n\nReturning to edit user menu."
            edit_user
        end
    end


    def self.user_save_repo
        space(1)
        puts "
        *************************************
          Would you like to save a repo(y)?
          Everything not saved will be lost!
        *************************************"
        input = get_user_input
        if input.downcase == 'y'
            if save_repo
                user_save_repo
            else 
                command_prompt
            end
        else
            command_prompt
        end
    end

    def self.save_repo
        space(1)
        puts "Enter the Repo ID, or type 'back'"
        id = get_user_input
        count = Repo.searched_repos.count 
        if id.downcase == 'back'
            return false 
        else 
            while id.to_i <= 0 || id.to_i > count do
                puts "Enter Repo ID between 1 and #{count}, or type 'back'."                
                id = get_user_input
                if id.downcase == "back"
                    return false
                end
            end
            repo = Repo.searched_repos[id.to_i - 1]
            already_saved = @@user.check_for_saved_repo(repo)
            if already_saved
                space
                puts "#{repo.name} already saved!"
            else
                UserRepo.create(@@user, repo)
                space
                puts "#{repo.name} saved!"
            end
        end
        return true
    end

    def self.exit_program
        exit_program_view
    end

    private
    def self.space(n=2)
        n.times do 
            puts "\n"
        end
    end
    

end
 
#1. Add to menu "Search user repo by keyword" using include
#2. Look into TTY and other project requirements
