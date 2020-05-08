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
         .d8888b.           888    888    888          888      
        d88P  Y88b          888    888    888          888      
        888    888          888    888    888          888      
        888         .d88b.  888888 81tch88888 888  888 88888b.  
        888  88888 d8P  Y8b 888    888    888 888  888 888  88b 
        888    888 88888888 888    888    888 888  888 888  888 
        Y88b  d88P Y8b.     Y88b.  888    888 Y88b 888 888 d88P 
         Y8888P88   Y8888    Y888  888    888   Y88888 88008P 
                                                                                                  
                         .d888                                  
                        d88P                                   
                        888                                     
                        888888 .d88b.  888d888.                  
                        888   d88  88b 888P   8                  
                        888   888  888 888                      
                        888   Y88..88P 888                      
                        888     Y88P   888                      
                                                                                                     
         .d8888b.  d8b 888         888    888          888      
        d88P  Y88b Y8P 888         888    888          888      
        888    888     888         888    888          888      
        888        888 888888      81tch88888 888  888 88888b.  
        888  88888 888 888         888    888 888  888 888  88b 
        888    888 888 888         888    888 888  888 888  888 
        Y88b  d88P 888 Y88b.       888    888 Y88b 888 888 d88P 
          Y8888P88 888   Y888      888    888   Y88888 88008P




Hello, valued user, and welcome to GetHub for GitHub! This readme will give you a brief overview of the intended purpose of this program, as well as how to use it. To get started, be advised that this is a command line interface application, and must be launched from inside the CLI in order to work. You are most likely already comfortable with this process if you are reading this because you must be looking for a way to easily search for GitHub repositories, but if you are new to this, don't worry, we've got you covered. Read on for instructions.

First, let's explain what this app does, and why you need it. This app is designed to allow any number of users to search for GitHub repositories, save the information pertaining to them, including the url from which they can be forked, and save them so that any given user can later retrieve that stored information in case they want to fork and clone said repositories. The app keeps track of multiple users and gives them each their own stored list of repositories, meaning that even on a shared device, the lists will be stored discretely. This should save the user time, as one does not need to search the web, or clutter up bookmarks in a browser. Furthermore, one will not see just a repository name or url upon initial search or revisitation of one's collection, but many other helpful bits of information as well, such as the description of the repository, star rating, and existing number of forks. Why would you use this? Maybe you are interested in something that you don't have the time to explore right now, or perhaps there are several repositories that sound useful, but you would like to save them for comparison. In any case, our hope is that this app saves you time and consolidates your resources. Let's get started!

If you haven't already, you will first need to fork and clone this repository into your local Git so that you have all the files contained within. Once that is done, you can use your terminal to change to the directory and then type and return 'bundle' in your terminal in order to install the needed gems. Run the file with 'rake run', or 'ruby <filepath>'.
