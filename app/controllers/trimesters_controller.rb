class TrimestersController < ApplicationController 
    before_action :require_admin, only: %i[ new create edit update destroy ]
    before_action :set_trimester, only: %i[show edit update destroy]

    def index 
        @trimesters = Trimester.all 
        render json: @trimesters 
    end 

    def show 
        @trimester = Trimester.find(params[:id])
    end 

    def edit 
        @trimester = Trimester.find(params[:id])
    end 

    def update 
        @trimester = Trimester.find_by(id: params[:id])

        unless @trimester 
            render plain: "Trimester not found", status: :not_found and return 
        end 

        if params[:trimester][:application_deadline].blank?
            render plain: "Application deadline required", status: :bad_request and return 
        end 

        begin
            deadline = Date.parse(params[:trimester][:application_deadline])
        rescue ArgumentError 
            render plain: "Invalid date format", status: :bad_request and return 
        end 

        if @trimester.update(application_deadline: deadline)
            redirect_to trimester_path(@trimester), notice: 'Trimester updated!'
        else  
            render :edit, status: :unprocessable_entity
        end 
    end 

    def set_trimester 
        @trimester = Trimester.find(params[:id])
    end 

end 