module Api 
  module V1 
    class StudentsController < ApplicationController
      protect_from_forgery with: :null_session 

      before_action :set_student, only: %i[ show edit update destroy ]
    
      # GET /students or /students.json
      def index
        # @students = Student.all
        render json: { students: Student.all }
      end
    
      # GET /students/1 or /students/1.json
      def show
        render json: { student: @student }
      end
    
      # GET /students/new
      def new
        @student = Student.new
      end
    
      # GET /students/1/edit
      def edit
      end
    
      # POST /students or /students.json
      def create
        @student = Student.new(student_params)
    
        if @student.save 
          render json: { student: @student }, status: :created 
        else  
          render json: { errors: @student.errors.full_messages }, status: :unprocessable_entity
        end 
      end
    
      # PATCH/PUT /students/1 or /students/1.json
      def update
        respond_to do |format|
          if @student.update(student_params)
            format.html { redirect_to @student, notice: "Student was successfully updated." }
            format.json { render :show, status: :ok, location: @student }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @student.errors, status: :unprocessable_entity }
          end
        end
      end
    
      # DELETE /students/1 or /students/1.json
      def destroy
        @student.destroy!
    
        respond_to do |format|
          format.html { redirect_to students_path, status: :see_other, notice: "Student was successfully destroyed." }
          format.json { head :no_content }
        end
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_student
          @student = Student.find(params[:id])
        end
    
        # Only allow a list of trusted parameters through.
        def student_params
          params.require(:student).permit(:first_name, :last_name, :email)
        end
    end
  end 
end 

    