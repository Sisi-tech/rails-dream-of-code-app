class TrimestersController < ApplicationController 
    def index 
        @trimesters = Trimester.all 
        render json: @trimesters 
    end 

    def show 
        @trimester = Trimester.find(params[:id])
    end 

end 