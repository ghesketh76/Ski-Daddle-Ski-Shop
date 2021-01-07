class Customer < ActiveRecord::Base 

    has_many :skis
    
    # def self.find_by_email email 
    #     customer = find_by email: email
    #     if customer
    #         puts "Welcome back #{customer.first_name} #{customer.last_name}"
    #         customer
    #     else
    #         puts "Sorry, you must be new here"
    #         gets
    #         # returnto the welcome  #put nil
    #     end
    # end


end


# maybe delete this find by email function to simplify