require "pry"
class User < ActiveRecord::Base

    has_many :user_repos
    has_many :repos, through: :user_repos

    @@user_repos = []

    def get_user_repo_ids
        UserRepo.all.reduce([]) do |memo, user_repo|
            if user_repo.user_id == self.id 
                memo << user_repo.repo_id 
            end
            memo
        end
    end

    def get_user_repos 
        repos = get_user_repo_ids
        @@user_repos = Repo.all.select do |repo|
            repos.include?(repo.id)
        end
        display_repos
    end

    def display_repos
        @@user_repos.each do |repo|
            Repo.new(
                name: repo["name"],
                description: repo["description"],
                url: repo["url"],
                private: repo["private"],
                owner_id: repo["owner_id"],
                forks: repo["forks"],
                stars: repo["watchers_count"]
            ).display(repo.id)
        end
    end

    def delete_repo(repo_id)
        row = UserRepo.where(repo_id: repo_id, user_id: self.id)
        UserRepo.delete(row)
        puts "repo deleted"
    end




end