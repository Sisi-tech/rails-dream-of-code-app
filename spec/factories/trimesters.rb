FactoryBot.define do 
    factory :trimester do 
        term { "Spring" }
        year { 2025 }
        start_date { Date.today - 1.week }
        end_date { Date.today + 1.months }
        application_deadline {Date.today - 2.weeks}
    end 
end 