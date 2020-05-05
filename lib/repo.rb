require 'rest-client'
require 'json'

class Repo < ActiveRecord::Base
    # Searches the github repo for key_terms
    
    @@temp_repos = []
    def self.search(key_term)
        response = RestClient.get "https://api.github.com/search/repositories?q=#{key_term}"
        @@temp_repos = JSON.parse(response.body)["items"]
        display_results
    end

    def self.display_results
        @@temp_repos.each_with_index do |repo, index|
            id = index + 1
            name = get_name(repo)
            desc = get_desc(repo)
            url = get_url(repo)
            forks = get_forks(repo)
            stars = get_stars(repo)
            is_private = is_private?(repo)
            print_result(id, name, desc, url, forks, stars, is_private)
        end
    end

    private 

    def self.get_name(repo)
        repo["name"]
    end

    def self.get_desc(repo)
        repo["description"]
    end
    def self.get_url(repo)
        repo["url"]
    end
    def self.get_forks(repo)
        repo["forks"]
    end
    def self.get_stars(repo)
        repo["watchers_count"]
    end
    def self.is_private?(repo)
        repo["private"]
    end

    def self.print_result(id, name, desc, url, forks, stars, is_private)
        puts "*" * 30
        puts "ID: #{id}"
        puts "Name: #{name}"
        puts "URL: #{url}"
        puts "Desc: #{desc}"
        puts "Forks: #{forks}, Stars: #{stars}, Private: #{is_private}"
    end
end

