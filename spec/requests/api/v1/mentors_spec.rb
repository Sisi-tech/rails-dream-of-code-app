require 'rails_helper' 

RSpec.describe "Mentors", type: :request do 
    describe "GET /mentors" do 
        let!(:mentor1) {
            Mentor.create!(
                first_name: "Jenny",
                last_name: "Lee",
                email: "jenny.lee@example.com",
                max_concurrent_students: 2,
            )
        }
        let!(:mentor2) {
            Mentor.create!(
                first_name: "Edward",
                last_name: "Kim", 
                email: "edward.kim@example.com",
                max_concurrent_students: 3,
            )
        }
        it "returns a JSON response containing all mentors" do 
            get "/mentors" 
            json_response = JSON.parse(response.body)

            expect(json_response.map { |t| t["first_name"] }).to include("Jenny", "Edward")
            expect(json_response.map { |t| t["last_name"] }).to include("Lee", "Kim")
            expect(json_response.map { |t| t["email"] }).to include("jenny.lee@example.com", "edward.kim@example.com")
            expect(json_response.map { |t| t["max_concurrent_students"] }).to include(2, 3)
        end 

        it "return an empty array if no mentor exist" do 
            Mentor.destroy_all 
            get "/mentors"
            json_response = JSON.parse(response.body)
            
            expect(json_response).to eq([])
        end 
    end 
end 
