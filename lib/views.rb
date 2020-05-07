module Views

    def greeting
        puts "
        .#####.              #     #               
        #     # ###### ##### #     # #    # #####. 
        #       #        #   #     # #    # #    # 
        #  #### #####    #   ####### #    # #####. 
        #  #  # #        #   #     # #    # #    # 
        #     # #        #   #     # #    # #    # 
         #####  ######   #   #     #  ####  #####  
                                                   
                                                   
                 ###### .####. #####.              
                 #      #    # #    #              
                 #####  #    # #    #              
                 #      #    # #####               
                 #      #    # #   #               
                 #       ####  #    #              
                                                   
        .#####.            #     #                      
        #     #  #  #####  #     #  #    #  #####.      
        #        #    #    #     #  #    #  #    #      
        #  ####  #    #    #######  #    #  #####.      
        #  #  #  #    #    #     #  #    #  #    #      
        #     #  #    #    #     #  #    #  #    #      
         #####   #    #    #     #   ####   #####       
                                                   "
    end

    def login_or_create_view
        space
        puts "
        *********************
        *   [ 1 ] Login     *
        *********************    
        *   [ 2 ] Create    *
        *********************
        *   [ 3 ] Exit      *
        *********************"        
        space(1)
    end

    def login_view 
        space(10)
        puts "
        *********************
        *       LOGIN       *
        *********************"
        space(1)
    end

    def create_view 
        space(10)
        puts "
        *********************
        *      CREATE       *
        *********************"
        space(1)
    end

    def welcome_user(username)
        space(10)
        puts "     Hello, #{username}! "
        space
    end

    def could_not_find_user_view(username)
        space
        puts "
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
           Could not find user '#{username}'
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    end

    def command_prompt_view
        space
        puts "
        ****************************
        *   [ 1 ] Search Repos     *
        ****************************    
        *   [ 2 ] List Your Repos  *
        ****************************
        *   [ 3 ] Delete a Repo    *
        ****************************
        *   [ 4 ] Update Username  *
        ****************************
        *   [ 5 ] Exit             *
        ****************************"
        space 
    end

    def exit_program_view
        puts "
        .#####.                                        
        #     # ###### ##### ####.  #####. #    # #####
        #       #    # #   # #    # #    #  #  #  #
        #  #### #    # #   # #    # #####    #    ####
        #  #  # #    # #   # #    # #    #   #    #
        #     # #    # #   # #    # #    #   #    #
         #####  ###### ##### #####  #####    #    #####
         "
    end


end
