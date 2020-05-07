class UserInterface 
    # Interacts with user via command line
    @@user = nil

    extend Views
    extend Commands 
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
            command_prompt
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
            search_repos
        when "2"
            list_user_repos
        when "3"
            delete_user_repo
        when "4"
            edit_user
        when "5"
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
            self.command_prompt
        else
            puts "Please select a valid action"
            edit_user
        end
    end


    def self.search_repos
        puts "Enter keyword to search: [ex: React]"
        keyword = get_user_input
        if keyword == "back"
            command_prompt
        elsif keyword != ""
            Repo.search(keyword)
            user_save_repo
        else
            self.search_repos
        end
    end

    def self.list_user_repos
        @@user.display_repos_by_user
        command_prompt
    end

    def self.delete_user_repo(err: nil)
        #add back function
        if  @@user.user_repos_count > 0
            space(10)
            @@user.display_repos_by_user
            space(1)
            if err 
                puts err
            end
            puts "Which Repo? [Repo ID]\n\nType '***' to delete all user repos."
            id = get_user_input
            if @@user.valid_repo_id(id)
                space(1)
                puts "Are you sure?"
                input = get_user_input
                space(1)
                if input.downcase == 'y'
                    @@user.delete_repo(id.to_i - 1)
                end
                command_prompt
            else
                delete_user_repo(err: "Enter a valid Repo ID")
            end
        else 
            space(3)
            puts "No repos to delete!"
            command_prompt
        end 
    end

    def self.delete_all_user_repos
        
    end

    def self.update_username
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
            command_prompt
        else 
            space
            puts "!" * 10
            puts "Enter valid name"
            puts "!" * 10
            self.update_username
        end
    end

    def self.user_delete_user
        puts "\n\n\n\n\nDelete user: #{@@user.username}.\n\n\nAre you sure? (y / n)" 
        input = get_user_input
        if input.downcase == "y"
            puts "\n\n\nGoodbye forever, #{@@user.username}.\n\n\nLogin to or create a different user.\n\n\nReturning to start menu."
            @@user.delete_user
            login_or_create_account
        elsif input.downcase == "n"
            puts "\n\n\nNo users deleted.\n\n\nReturning to edit user menu."
            edit_user
        else
            puts "\n\n\nPlease enter a valid command."
            user_delete_user
        end
    end


    def self.user_save_repo
        space(1)
        puts "
        *************************************
         Would you like to save a repo?[y,n]
        *************************************"

        input = get_user_input
        if input.downcase == "y"
            save_repo
           
            user_save_repo
        else 
            command_prompt
        end
    end

    def self.save_repo
        puts "Enter the Repo ID, or type 'back'"
        id = get_user_input
        

        if id.downcase == 'back'
            command_prompt
        elsif !id.empty? && id.to_i != 0 && Repo.all.exclude?(repo)
            repo = Repo.searched_repos[id.to_i - 1]
            UserRepo.create(@@user, repo)
            puts "#{repo.name} saved."
        else
            puts "Repo already taken"
            self.save_repo
        end
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

#1. Limit description word count to 200
#2. Add to menu "Search user repo by keyword" using include
#3. Add to menu "Delete user"
#4. Add conditional option to delete all repos for a user with "*" and inform in prompt
#5. Look into TTY and other project requirements
#6. Fix repo search > save > list > exit returns to command_prompt one extra time
