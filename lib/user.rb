require "pry"
class User < ActiveRecord::Base

    has_many :user_repos
    has_many :repos, through: :user_repos

    def display_repos_by_user    
        get_repos.each_with_index do |repo, index|
            repo.display(id: index + 1)
        end
    end

    def get_repos
        User.find_by(username: username).repos 
    end

    def get_repos_by_keyword(keyword)
        owned = get_repos.select {|repo| repo.name.include?(keyword)}
        owned.each {|repo| repo.display}
    end

    def user_repos_count
        get_repos.count
    end
    
    def check_for_saved_repo(repo)
        get_repos.find do |saved_repo|
            saved_repo.name == repo.name && saved_repo.description == repo.description 
        end
    end

    def delete_repo(index)
        repo = get_repos[index]
        if repo
            row = UserRepo.where(repo_id: repo.id, user_id: self.id)
            UserRepo.delete(row)
            puts "#{repo.name} has been deleted."
        else 
            false
        end
    end

    def delete_all_user_repos
        get_repos.each do |repo|
            row = UserRepo.where(repo_id: repo.id, user_id: self.id)
            UserRepo.delete(row)
        end
    end

    def delete_user
        delete_all_user_repos
        self.delete
    end


    def update_username(new_name)
        User.find(self.id).update(username: new_name)
        "Username has been changed to #{new_name}"
    end

    def valid_repo_id(id)
        count = user_repos_count
        !id.empty? && (id.to_i > 0 && id.to_i <= count)
    end

    def self.login(username)
        user = self.find_by(username: username)
    end


end
