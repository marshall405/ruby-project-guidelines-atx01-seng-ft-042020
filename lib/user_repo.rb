class UserRepo < ActiveRecord::Base

    
    def self.create(user, repo)
        repo.save 
        super(user_id: user_id, repo_id: repo.id)
    end

end