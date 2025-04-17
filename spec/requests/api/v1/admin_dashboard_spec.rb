require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do 
    let!(:current_trimester) do
        create(:trimester, term: "Current term", year: 2025, start_date: Date.today - 1.week, end_date: Date.today + 1.month)
      end
    
      let!(:upcoming_trimester) do
        create(:trimester, term: "Upcoming term", year: 2025, start_date: Date.today + 1.month, end_date: Date.today + 3.months)
      end
    
      let!(:past_trimester) do
        create(:trimester, term: "Past term", year: 2024, start_date: Date.today - 6.months, end_date: Date.today - 4.months)
      end
    
      let!(:current_course) do
        create(:course, trimester: current_trimester, coding_class: create(:coding_class, title: "Ruby", description: "Learn Ruby"))
      end
    
      let!(:upcoming_course) do
        create(:course, trimester: upcoming_trimester, coding_class: create(:coding_class, title: "Python", description: "Learn Python"))
      end

    describe 'GET /dashboard' do 
        it 'returns a 200 OK status' do 
            get "/dashboard"
            expect(response).to have_http_status(:ok)
        end 

        it 'displays the current trimester' do 
            get "/dashboard"
            expect(response.body).to include("Current term - 2025")
        end 

        it 'displays the past trimester' do 
            get "/dashboard"
            expect(response.body).to include("Past term")
        end 

        it 'displays links to the course in the upcoming trimester' do 
            get "/dashboard"
            expect(response.body).to include("Upcoming term - 2025")
        end 
    end
end 
