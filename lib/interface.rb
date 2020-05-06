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
        if action == "1"
            login
        elsif action == "2"
            create_account
        else
            "invalid input"
            login_or_create_account
        end
    end

    def self.get_user_input
        gets.chomp
    end

    def self.create_account(message=nil)
        space(1)
        if message
            puts message
        end
        puts "*********************"
        puts "*      CREATE       *"
        puts "*********************"
        puts "Enter a username:"
        username = get_user_input
        self.create_account if username == ""
        user = User.find_by(username: username)
        if user
            create_account("#{username} is unavailable")
        end
        puts "Enter your name:"
        name = get_user_input
        @@user = User.create(username: username, name: name)
        command_prompt
    end

    def self.login
        space(1) 
        puts "*********************"
        puts "*       LOGIN       *"
        puts "*********************"
        puts "Enter your username:"
        username = get_user_input
        user = User.find_by(username: username)
        if user 
            @@user = User.new(username: user["username"], name: user["name"], id: user["id"])
            command_prompt
        else
            puts "Could not find user \"#{username}\""
            login_or_create_account
        end
    end

    def self.command_prompt
        puts "****************************"
        puts "*   [ 1 ] Search Repos     *"
        puts "****************************"    
        puts "*   [ 2 ] List Your Repos  *"
        puts "****************************"
        puts "*   [ 3 ] Delete a Repo    *"
        puts "****************************"
        puts "*   [ 4 ] Update Username  *"
        puts "****************************"
        puts "*   [ 5 ] Exit             *"
        puts "****************************"
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
        @@user.get_user_repos 
        command_prompt
    end

    def self.delete_user_repo
        puts "Which repo?"
        id = get_user_input
        puts "are you sure?????????"
        y_n = get_user_input
        if y_n == "y"
            @@user.delete_repo(id)
        end
        command_prompt
    end

    def self.update_username
        puts "Current name: #{@@user.username}"
        puts "Enter new username: or type 'back'"
        name = get_user_input

        if name == "back"
            command_prompt
        elsif name != "" && name != @@user.username
            @@user.username = User.update_username(@@user.username, name)
            puts "*" * 10
            puts "Username changed to '#{@@user.username}'!"
            command_prompt
        else 
            puts "Enter valid name"
            self.update_username
        end

    end

    def self.exit_program
        puts "Goodbye"
    end

    def self.user_save_repo
        space(1)
        puts "*************************************"
        puts "Would you like to save a repo?[y,n]"
        puts "*************************************"

        input = get_user_input
        if input == "y" || input == "Y"
            save_repo
            puts "Repo saved."
            user_save_repo
        end
        command_prompt
    end

    def self.save_repo
        puts "Enter the Repo ID: "
        id = get_user_input
        if id
            UserRepo.create(@@user, Repo.searched_repos[id.to_i])
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
