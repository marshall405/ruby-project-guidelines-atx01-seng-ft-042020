# Module One Final Project Guidelines

Congratulations, you're at the end of module one! You've worked crazy hard to get here and have learned a ton.

For your final project, we'll be building a Command Line database application.

## Project Requirements

### Option One - Data Analytics Project

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have at minimum three models including one join model. This means you must have a many-to-many relationship.
3. You should seed your database using data that you collect either from a CSV, a website by scraping, or an API.
4. Your models should have methods that answer interesting questions about the data. For example, if you've collected info about movie reviews, what is the most popular movie? What movie has the most reviews?
5. You should provide a CLI to display the return values of your interesting methods.  
6. Use good OO design patterns. You should have separate classes for your models and CLI interface.

  **Resource:** [Easy Access APIs](https://github.com/learn-co-curriculum/easy-access-apis)

### Option Two - Command Line CRUD App

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have a minimum of three models.
3. You should build out a CLI to give your user full CRUD ability for at least one of your resources. For example, build out a command line To-Do list. A user should be able to create a new to-do, see all todos, update a todo item, and delete a todo. Todos can be grouped into categories, so that a to-do has many categories and categories have many to-dos.
4. Use good OO design patterns. You should have separate models for your runner and CLI interface.

### Brainstorming and Proposing a Project Idea

Projects need to be approved prior to launching into them, so take some time to brainstorm project options that will fulfill the requirements above.  You must have a minimum of four [user stories](https://en.wikipedia.org/wiki/User_story) to help explain how a user will interact with your app.  A user story should follow the general structure of `"As a <role>, I want <goal/desire> so that <benefit>"`. In example, if we were creating an app to randomly choose nearby restaurants on Yelp, we might write:

* As a user, I want to be able to enter my name to retrieve my records
* As a user, I want to enter a location and be given a random nearby restaurant suggestion
* As a user, I should be able to reject a suggestion and not see that restaurant suggestion again
* As a user, I want to be able to save to and retrieve a list of favorite restaurant suggestions

## Instructions

1. Fork and clone this repository.
2. Build your application. Make sure to commit early and commit often. Commit messages should be meaningful (clearly describe what you're doing in the commit) and accurate (there should be nothing in the commit that doesn't match the description in the commit message). Good rule of thumb is to commit every 3-7 mins of actual coding time. Most of your commits should have under 15 lines of code and a 2 line commit is perfectly acceptable.
3. Make sure to create a good README.md with a short description, install instructions, a contributors guide and a link to the license for your code.
4. Make sure your project checks off each of the above requirements.
5. Prepare a video demo (narration helps!) describing how a user would interact with your working project.
    * The video should:
      - Have an overview of your project.(2 minutes max)
6. Prepare a presentation to follow your video.(3 minutes max)
    * Your presentation should:
      - Describe something you struggled to build, and show us how you ultimately implemented it in your code.
      - Discuss 3 things you learned in the process of working on this project.
      - Address, if anything, what you would change or add to what you have today?
      - Present any code you would like to highlight.   
7. *OPTIONAL, BUT RECOMMENDED*: Write a blog post about the project and process.

---
### Common Questions:
- How do I turn off my SQL logger?
```ruby
# in config/environment.rb add this line:
ActiveRecord::Base.logger = nil
```


* Github repo search
* Search for github repos by key terms, save repos you like, view your saved repos, delete saved repos.
* As a user, I want to search for repositorys using key search terms 
* As a user, I want to save a repo
* As a user, I want to view my saved repos 
* As a user, I want to delete a repo
* As a user, I want to update ????????????????

* https://api.github.com/search/repositories?q=#{insert_search_term}

* Database Structure
  * Tables

      users
        username string
        name string
      
      repos
        name string
        description string
        url string
        private boolean
        owner_id integer
        forks integer
        stars integer

      user_repos
        user_id integer
        repo_id integer

* Models
    User
      instantiate with username and name, id=nil
      #methods
        save_repo(self.id, repo.id)
            -UserRepo.save(self.id, repo.id)
        display_repos
            -UserRepo.get_user_repos(self.id)
      .methods
        find_user
        create_user
    
    Repo

      .methods
        search(keyword)
            -return response 
        display_results
            -display each repo 
        save
            -save repo 
            -use temp array of searched repos 


    UserRepo
      .methods
        all
          -returns all user_repos
          
        save_repo(user_id, repo_id)
          -user_id
          -repo_id

* Views
    Command Line Interface

    Ask user to login or create acct(login/create)
      -If login
        --Instantiate User class with data from users table
      -If create
        --Ask for username
        --Ask for name
        --Instantiate User.create with username and name
    List of commands (What would you like to do?enter a number)
      [1]-Search for repos
        -Ask user for key term to use in search
        -return a printed out list of repos matching the search terms
        --To save a repo type "save"
            ---ask user which repo [num] to save 
            ---save and display message of success of failure
            ---Go back to List of Commands
      [2]-List of saved repos
        --Print list of saved repos 
        --Go back to List of Commands
      [3]-Delete repo
        --Ask user what repo [num] to delete
        --get user input and pass to delete method
        -- display message "repo deleted"
        --Go back to List of Commands