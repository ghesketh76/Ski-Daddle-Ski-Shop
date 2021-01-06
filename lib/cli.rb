class Cli 

    ActiveRecord::Base.logger = nil

    def prompt
        TTY::Prompt.new
    end

    attr_accessor :customer

    def clear 
        system("clear)")
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

        puts "you did it"    
        binding.pry
    end


end