class AdminDashboardController < ApplicationController
    def index
        @current_trimester = Trimester.find_by(term: "Current term")
        @upcoming_trimester = Trimester.find_by(term: "Upcoming term")
        @past_trimester = Trimester.find_by(term: "Past term")
    end
end
  