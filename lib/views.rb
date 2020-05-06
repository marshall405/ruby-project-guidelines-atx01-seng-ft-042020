module Views

    def greeting
        puts "
         #####               #     #               
        #     # ###### ##### #     # #    # #####  
        #       #        #   #     # #    # #    # 
        #  #### #####    #   ####### #    # #####  
        #     # #        #   #     # #    # #    # 
        #     # #        #   #     # #    # #    # 
         #####  ######   #   #     #  ####  #####  
                                                   
                                                   
                 ######  ####  #####               
                 #      #    # #    #              
                 #####  #    # #    #              
                 #      #    # #####               
                 #      #    # #   #               
                 #       ####  #    #              
                                                   
         #####          #     #                    
        #     # # ##### #     # #    # #####       
        #       #   #   #     # #    # #    #      
        #  #### #   #   ####### #    # #####       
        #     # #   #   #     # #    # #    #      
        #     # #   #   #     # #    # #    #      
         #####  #   #   #     #  ####  #####       
                                                   "
    end

    def login_or_create_view
        space
        puts "*********************"
        puts "*   [ 1 ] Login     *"
        puts "*********************"    
        puts "*   [ 2 ] Create    *"
        puts "*********************"
        puts "*   [ 3 ] Exit      *"
        puts "*********************"        
        space(1)
    end

    def login_view 
        space(10)
        puts "*********************"
        puts "*       LOGIN       *"
        puts "*********************"
        space(1)
    end

    def create_view 
        space(10)
        puts "*********************"
        puts "*      CREATE       *"
        puts "*********************"
        space(1)
    end

    def welcome_user(username)
        space(10)
        puts "     Hello, #{username}! "
        space
    end

    def could_not_find_user_view(username)
        space
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        puts "  Could not find user \"#{username}\""
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    end

    def command_prompt_view
        space
        puts "****************************"
        puts "*   [ 1 ] Search Repos     *"
        puts "****************************"    
        puts "*   [ 2 ] List Your Repos  *"
        puts "****************************"
        puts "*   [ 3 ] Delete a Repo    *"
        puts "****************************"
        puts "*   [ 4 ] Update Username  *"
        puts "****************************"
        puts "*   [ 5 ] Exit             *"
        puts "****************************"
        space 
    end

    def exit_program_view
        puts "
         #####                                    #####
        #     # ###### ##### ####   # # #  #    # #
        #       #    # #   # #    # #    #  #  #  #
        #  #### #    # #   # #    # #####    #    ####
        #     # #    # #   # #    # #    #   #    #
        #     # #    # #   # #    # #    #   #    #
         #####  ###### ##### #####  #####    #    #####
         "
    end


end
