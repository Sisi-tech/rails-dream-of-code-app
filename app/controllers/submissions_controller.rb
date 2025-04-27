require 'ostruct'
class SubmissionsController < ApplicationController
  # GET /submissions/new
  def new
    @course = Course.find(params[:course_id])
    @submission = Submission.new
    # TODO: What set of enrollments should be listed in the dropdown?
    @enrollments = @course.enrollments.includes(:student).map do |enrollment|
       OpenStruct.new(id: enrollment.id, student_name: "#{enrollment.student.first_name} #{enrollment.student.last_name}")
    end 
    @mentors = Mentor.all.map do |mentor|
      OpenStruct.new(id: mentor.id, mentor_name: "#{mentor.first_name} #{mentor.last_name}")
    end 
    # TODO: What set of lessons should be listed in the dropdown?
    @lessons = @course.lessons 
    @students = @course.enrollments.includes(:student).map(&:student)
  end

  def create
    @course = Course.find(params[:course_id])
    @submission = Submission.new(submission_params)
  
    @submission.student = Enrollment.find(@submission.enrollment_id).student
  
    if @submission.save
      redirect_to course_path(@course), notice: 'Submission was successfully created.'
    else
      # Reset dropdowns
      @enrollments = @course.enrollments.includes(:student).map do |enrollment|
        OpenStruct.new(id: enrollment.id, student_name: "#{enrollment.student.first_name} #{enrollment.student.last_name}")
      end
  
      @mentors = Mentor.all.map do |mentor|
        OpenStruct.new(id: mentor.id, mentor_name: "#{mentor.first_name} #{mentor.last_name}")
      end
  
      @lessons = @course.lessons
      @students = @course.enrollments.includes(:student).map(&:student)
      render :new, status: :unprocessable_entity
    end
  end
  

  # GET /submissions/1/edit
  def edit
  end

  # PATCH/PUT /submissions/1 or /submissions/1.json
  def update
  end

  private
  # Only allow a list of trusted parameters through.
  def submission_params
    params.require(:submission).permit(:student_id, :lesson_id, :enrollment_id, :mentor_id, :pull_request_url, :review_result, :reviewed_at)
  end
end
