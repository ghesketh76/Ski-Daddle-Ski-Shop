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
        puts "Welcome to the Ski Shop!"
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
            puts "Welcome back #{customer.first_name} #{customer.last_name}"
            new_ski
        else
            puts "Sorry we couldnt find your username"
            puts "Please press Enter to create a new account"
            gets
            sign_up
            # user_input = prompt.ask "username does not exist. Please enter your email..."
            # self.customer = Customer.find_by_email user_input
            #if else statement here to handle nil or input
        end
    end
    

    def sign_up
        clear
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
        @requested_service = prompt.select("How can we make your skis better today", Service.all.pluck(:service_name))
        service_estimation
    end

    def service_estimation
        clear
        current_service = Service.all.find do |service|
            service.service_name == @requested_service
        end   
        puts "Your #{@requested_service} will cost $#{current_service.cost} and it will take us about #{current_service.service_time} minutes to complete."
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
        @current_ski.ski_condition = "Tuned"
    end

    def conduct_service
        puts "We are currently working on your #{@current_ski.make} #{@current_ski.model} that is currently #{@current_ski.ski_condition}."
       
        # puts "Your current ski condition is "    #add current ski condition
        puts " "
        bar = TTY::ProgressBar.new("The techs are working on your skis!!! [:bar]", total: 30)
        30.times do
            sleep(0.1)
            bar.advance(1)
        end
        tune_ski
        clear
        puts "Your ski condition is now #{@current_ski.ski_condition} " #add current ski condition
        puts "You've bugged us long enough, time for you to go shred!"
    end

end