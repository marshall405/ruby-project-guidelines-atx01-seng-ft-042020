require "pry"
class User < ActiveRecord::Base

    has_many :user_repos
    has_many :repos, through: :user_repos

    @@user_repos = []

    def display_repos_by_user
        user = User.find_by(username: username)
        @@user_repos = user.repos 
        user.repos.each_with_index do |repo, index|
            repo.display(id: index + 1)
        end
    end
    def user_repos_count
        User.find_by(username: username).repos.count
    end
    
    def delete_repo(index)
        repo = @@user_repos[index]
        if repo
            row = UserRepo.where(repo_id: repo.id, user_id: self.id)
            UserRepo.delete(row)
            puts "#{repo.name} has been deleted."
        else 
            false
        end
    end

    def update_username(new_name)
        User.find(self.id).update(username: new_name)
        "Username has been changed to #{new_name}"
    end

    def self.login(username)
        user = self.find_by(username: username)
    end


end