FactoryBot.define do
    factory :course do
      start_date { Date.today }
      end_date { Date.today + 3.months }
      max_enrollment { 20 }
      association :trimester
      association :coding_class
    end
  end
  