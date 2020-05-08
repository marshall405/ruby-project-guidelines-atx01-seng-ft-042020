require 'rest-client'
require 'json'
require 'pry'
require 'colorize'

class Repo < ActiveRecord::Base

    has_many :user_repos
    has_many :users, through: :user_repos

    @@temp_repos = []

    


    def display(id: nil)
        id = id.nil? ? self.id : id 
        print "
        *************************************".green.on_black
        Repo.space(1)
        print "Repo ID: #{id}".green.on_black
        Repo.space(1)
        print "Name: #{self.name}".green.on_black
        Repo.space(1)
        print "URL: #{self.url}".green.on_black
        Repo.space(1)
        print "Desc: #{self.description}".green.on_black
        Repo.space(1)
        print "Forks: #{self.forks}, Stars: #{self.stars}, Private: #{self.private}, Owner ID: #{self.owner_id}".green.on_black
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

    private
    def self.space(n=2)
        n.times do 
            print "\n".green.on_black
        end
    end
end

