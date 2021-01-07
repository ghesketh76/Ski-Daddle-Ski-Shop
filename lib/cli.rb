class Cli 

    ActiveRecord::Base.logger = nil

    def prompt
        TTY::Prompt.new
    end

    attr_accessor :customer

    def clear 
        system("clear")
    end

    def intialize customer=nil
        @customer = customer
    end

    def welcome
        clear
        puts "Welcome to the Ski Daddle Ski Shop!"
        puts "
                      /----|       .         .
        .            /     [   .        .         .
               ______|---- _|__     .        .
      .     _--    --\_<\_//   \-----           .
           _  _--___   \__/     ___  -----_ **     *
      *  _- _-      --_         /  [ ----__  --_  *
      */__-      .    [           _[  *** --_  [*
        [*/ .          __[/-----__/   [**     [*/
              .     /--  /            /
           .        /   /   /[----___/        .
                   /   /*[  !   /==/              .
        .         /   /==[   |/==/      .
                _/   /=/ | _ |=/   .               .
               /_   //  / _ _//              .
       .       [ '//    |__//    .    .            .
              /==/  .  /==/                .
            /==/     /==/                       .
          /==/     /==/       .       .    .
       _/==/    _/==/            .
       [|*      [|*                   "
       puts " "
        user_input = prompt.yes? "Have you visited us before?"
        if user_input
            sign_in    
        else
            sign_up
        end
    end

    def sign_in 
        user_input = prompt.ask "Please enter your username..."
        found_customer = Customer.find_by(username: user_input)
        if found_customer
            self.customer = found_customer
            puts "Welcome back #{customer.first_name} #{customer.last_name}."
            pass_input = prompt.ask "Please enter your password..."
            if pass_input == @customer.password
                customer_options
            else
                puts "Sorry that does not match our records, please try again."
                sign_in
            end
        else
            puts "Sorry we couldnt find your username!"
            puts "Please press ENTER to create a new account..."
            gets
            clear
            sign_up
        end
    end
    
    def customer_options
        clear
        customer_options_array = ["Work on my skis", "Manage my account"]
        user_input = prompt.select("How can we help you today?", customer_options_array)
        if user_input == customer_options_array[0]
            new_ski
        else user_input == customer_options_array[1]
            manage_account
        end
    end

    def manage_account
        user_input = prompt.yes? "Would you like to delete your account?"
        if user_input
            @customer.destroy
            clear
            puts "We hate to see you go, but we love to watch you leave!"
            exit
        else
            puts "Press ENTER to return to ski shop..."
            gets 
            welcome
        end
    end
    def sign_up
        first_name = prompt.ask "What is your first name?"
        last_name = prompt.ask "What is your last name?"
        age = prompt.ask "How old are you?"
        email = prompt.ask "What is your email address?"
        username = prompt.ask "What would you like your username to be?"
        password = prompt.ask "What would you like your password to be?"

        self.customer = Customer.create(
            first_name: first_name,
            last_name: last_name,
            age: age,
            email: email,
            username: username,
            password: password
        )  
        new_ski  
    end

    def new_ski
        clear
        puts "Tell us about your skis!"
        puts " "
        ski_type_array = ["Powder", "All Mountain", "Race", "Park"]
        ski_condition_array = ["Slow", "Dull Edges", "Destroyed by Rocks", "New pair of skis"]
        make = prompt.ask "Who is the manufacturer of your skis?"
        model = prompt.ask "What is the model of the skis?"
        ski_length = prompt.ask "What length are these skis?"
        ski_type = prompt.select("What type of skis are these?", ski_type_array)
        ski_condition = prompt.select("What condition are your skis in?", ski_condition_array)

        #save this to a instance variable?
        @current_ski = Ski.create(                         
            make: make,
            model: model,
            ski_type: ski_type,
            ski_length: ski_length,
            ski_condition: ski_condition,
            customer_id: self.customer.id
        )
        select_service
    end

    def select_service
        clear
        @requested_service = prompt.select("How can we make your skis better today?", Service.all.pluck(:service_name))
        service_estimation
    end

    def service_estimation
        clear
        current_service = Service.all.find do |service|
            service.service_name == @requested_service
        end   
        puts "Your #{@requested_service} will cost $#{current_service.cost} and it will take us about #{current_service.service_time} minutes to complete."
        puts " "
        answer = prompt.yes? "Would you like to proceed?"
        clear
        if answer
            conduct_service
        else
            next_answer = prompt.yes? "Would you like to select a different service?"
            if next_answer
                select_service
            else
                clear
                puts "Thanks for dropping by!"
                exit
            end
        end
    end

    def tune_ski
        @current_ski.ski_condition = "tuned"
    end

    def conduct_service
        puts "We are currently working on your #{@current_ski.make} #{@current_ski.model} that is currently #{@current_ski.ski_condition}."
        puts " "
        puts "Press ENTER to watch the magic happen..."
        gets
        clear
       
        bar = TTY::ProgressBar.new("The techs are working on your skis!!! [:bar]", total: 30)
        30.times do
            sleep(0.1)
            bar.advance(1)
        end
        tune_ski
        clear
        puts "Your ski condition is now #{@current_ski.ski_condition}."
        puts " "
        puts "
                        *
                        XX
                    MMMMM
                    //(00
                    .:.....
                .:::::::::
                :: %%%%%% ::.
                ::  ::::::  :::::::I)
                (%  ::::::         |
                /   |   /_____     |
                /    |         ))   |
                /      ------/ //    |
                /            / //     |
                /            / //      |
                *            ZZZZ       *
                _________ZZZZZZ_________//_//
                ------------------------------------    
        "
        puts " "
        puts "You've bugged us long enough, time for you to go shred!"
        puts " "
        puts " "
    end

end