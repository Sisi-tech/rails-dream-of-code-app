FactoryBot.define do 
    factory :student do 
        first_name {"Test"}
        last_name {"Student"}
        email { Faker::Internet.email }
    end 
end 


