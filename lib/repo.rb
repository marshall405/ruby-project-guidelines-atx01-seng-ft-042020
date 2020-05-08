require 'rest-client'
require 'json'
require "pry"
class Repo < ActiveRecord::Base

    has_many :user_repos
    has_many :users, through: :user_repos

    @@temp_repos = []

    


    def display(id: nil)
        id = id.nil? ? self.id : id 
        puts "*" * 30
        puts "Repo ID: #{id}"
        puts "Name: #{self.name}"
        puts "URL: #{self.url}"
        puts "Desc: #{self.description}"
        puts "Forks: #{self.forks}, Stars: #{self.stars}, Private: #{self.private}, Owner ID: #{self.owner_id}"
    end

    def self.search(key_term)
        @@temp_repos = []
        response = RestClient.get "https://api.github.com/search/repositories?q=#{key_term}&per_page=100"
        JSON.parse(response.body)["items"].each do |repo|
            desc = repo["description"] ? repo["description"][0..800] + "..." : repo["description"]
            @@temp_repos << new(
                name: repo["name"],
                description: desc,
                url: repo["url"],
                private: repo["private"],
                owner_id: repo["owner"]["id"],
                forks: repo["forks"],
                stars: repo["watchers_count"]
                )
        end
        display_results
    end

    def self.find_users_by_repo_id(id)
        # currently not tied to user interface!!!!!!!!!
        Repo.find(id).users 
    end

    def self.display_results
        @@temp_repos.each_with_index do |repo, index|
            repo.display(id: index + 1)
        end
    end

    def self.searched_repos
        @@temp_repos
    end
end

