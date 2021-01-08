# Ski Daddle Ski Shop
> The chillest ski shop on the front range!

## Demonstration Video

[Ski Daddle Ski Shop Demo](https://youtu.be/v3kaePbHWaQ)

## General Info

Ski Daddle Ski Shop is a CLI application that gives the user a virtual ski shop experience. The customer has the ability to create and save a personal account, submit a pair of skis that need work and links them to their personal account. The customer then selects a service for the ski, and watches as it is tuned! The customer also has the ability to delete their personal account. Come on in and lets get you on the slopes!

## Technologies
* Ruby - Version 2.6.1
* ActiveRecord - Version 6.0
* Sinatra-ActiveRecord - Version 2.0
* Rake - Version 13.0
* SQLite3 - Version 1.4
* TTY-Prompt - Version 0.23.0
* TTY-ProgressBar - 0.17.0

## Setup

 To get started, clone the repository from github to your computer.

In your terminal, run the following commands:


```ruby
 $ bundle
 $ rake db:migrate
 $ rake db:seed 
 ```


## Running the program

Run the following command in your terminal:
``` $ ruby runner.rb ```

Follow the onscreen prompts!

## Code Examples

```ruby
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
``` 

```ruby
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
```
## Features
* Create customer account
* Require password for sign in
* Create new ski entry
* Select ski service
* Conduct ski service
* Delete customer account

To-do list:
* Add function for snow reports via API
* Use email to recover account

## Contact
Created by [Grant Hesketh](https://www.linkedin.com/in/granthesketh/) and [Luke Thinnes](https://www.linkedin.com/in/luke-thinnes-37a2a014b/) 

Feel free to contact us!
