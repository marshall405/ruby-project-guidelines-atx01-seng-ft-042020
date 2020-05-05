require 'rest-client'
require 'json'
require "pry"
class Repo < ActiveRecord::Base

    @@temp_repos = []

    def display(index)
        puts "*" * 30
        puts "Save ID: #{index}"
        puts "Name: #{self.name}"
        puts "URL: #{self.url}"
        puts "Desc: #{self.description}"
        puts "Forks: #{self.forks}, Stars: #{self.stars}, Private: #{self.private}, Owner ID: #{self.owner_id}"
    end
    def self.search(key_term)
        response = RestClient.get "https://api.github.com/search/repositories?q=#{key_term}"
        JSON.parse(response.body)["items"].each do |repo|
            @@temp_repos << new(
                name: repo["name"],
                description: repo["description"],
                url: repo["url"],
                private: repo["private"],
                owner_id: repo["owner"]["id"],
                forks: repo["forks"],
                stars: repo["watchers_count"]
                )
        end
        display_results
    end


    def self.display_results
        @@temp_repos.each_with_index do |repo, index|
            repo.display(index)
        end
    end

    def self.searched_repos
        @@temp_repos
    end
end

