require "pry"
class User < ActiveRecord::Base

    has_many :user_repos
    has_many :repos, through: :user_repos

    @@user_repos = []

    def self.display_repos_by_user(user)
        user = User.find(user.id)
        user.repos.each do |repo|
            repo.display
        end
    end

    def delete_repo(repo_id)
        row = UserRepo.where(repo_id: repo_id, user_id: self.id)
        UserRepo.delete(row)
        "Repo ID: #{repo_id} has been deleted."
    end

    def update_username(new_name)
        User.find(self.id).update(username: new_name)
        "Username has been changed to #{new_name}"
    end



end