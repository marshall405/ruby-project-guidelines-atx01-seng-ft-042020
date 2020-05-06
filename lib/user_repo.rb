class UserRepo < ActiveRecord::Base
    belongs_to :user
    belongs_to :repo 
    
    def self.create(user, repo)
        repo.save 
        super(user_id: user.id, repo_id: repo.id)
    end

end