class User < ActiveRecord::Base

    has_many :user_repos
    has_many :repos, through: :user_repos

    @@user_repos = []

    # def delete()
    #     UserRepo.where(user_id: self.id && repo_id: self.repo).delete
    # end

end