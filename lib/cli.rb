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
        puts "Welcome to the Ski Shop!"
        user_input = prompt.yes? "Have you visited us before?"
        if user_input
            sign_in    #make method
        else
            sign_up
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
        puts "Tell us about your skis!"
        ski_type_array = ["Powder", "All Mountain", "Race", "Park"]
        make = prompt.ask "Who is the manufacturer of your skis?"
        model = prompt.ask "What is the model of the skis?"
        ski_length = prompt.ask "What length are these skis?"
        ski_type = prompt.select("What type of skis are these?", ski_type_array)
        
        Ski.create(
            make: make,
            model: model,
            ski_type: ski_type,
            ski_length: ski_length,
            customer_id: self.customer.id
        )
    end


end