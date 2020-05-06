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
            update_username
        when "5"
            exit_program
        else 
            puts "Invalid Action"
            command_prompt
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

    def self.delete_user_repo
        puts "Which Repo? [Repo ID]"
        id = get_user_input
        puts "Are you sure?[y,n]"
        y_n = get_user_input
        if y_n.downcase == "y"
            puts @@user.delete_repo(id.to_i)
        end
        command_prompt
    end

    def self.update_username
        puts "Current username: #{@@user.username}"
        puts "Enter new username: or type 'back'"
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

    def self.exit_program
        exit_program_view
    end

    def self.user_save_repo
        space(1)
        puts "*************************************"
        puts "Would you like to save a repo?[y,n]"
        puts "*************************************"

        input = get_user_input
        if input.downcase == "y"
            save_repo
            puts "Repo saved."
            user_save_repo
        else 
            command_prompt
        end
    end

    def self.save_repo
        puts "Enter the Repo ID: "
        id = get_user_input
        if id.downcase == 'back'
            command_prompt
        elsif !id.empty? && id.to_i != 0
            UserRepo.create(@@user, Repo.searched_repos[id.to_i - 1])
        else
            self.save_repo
        end
    end

    private
    def self.space(n=2)
        n.times do 
            puts "\n"
        end
    end



end

#1. Move methods from interface to appropriate classes
#2. Add to menu "Search user repo by keyword" using include
#3. Add to menu "Delete user"
#4. Add conditional option to delete all repos for a user with "*" and inform in prompt
#5. Look into TTY and other project requirements
#6. Fix repo search > save > list > exit returns to command_prompt one extra time
