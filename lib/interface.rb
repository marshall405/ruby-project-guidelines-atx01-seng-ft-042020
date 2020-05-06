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
        puts "*   [ 4 ] Update Name      *"
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
            update_user_name
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
        pp @@user.get_user_repos 

        # UserRepo.select(user_id).each_with_index do |user_repo, index|
        #     repo = Repo.find(user_repo.repo_id)
        #     Repo.new(
        #         name: repo["name"],
        #         description: repo["description"],
        #         url: repo["url"],
        #         private: repo["private"],
        #         owner_id: repo["owner_id"],
        #         forks: repo["forks"],
        #         stars: repo["watcher_count"]
        #     ).display(index + 1)
        # end
        command_prompt
    end

    def self.delete_user_repo
        
    end

    def self.update_user_name

    end

    def self.exit_program

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
