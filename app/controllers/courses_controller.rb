class CoursesController < ApplicationController
  # GET /courses or /courses.json
  def index
    current_date = Date.today 
    current_trimester = Trimester.where("Start_date <= ? AND end_date >= ?", current_date, current_date).first
    @courses = current_trimester ? Course.where(trimester_id: current_trimester.id) : []

    respond_to do |format|
      format.html 
      format.json { render json: { courses: @courses }}
    end 
  end

  def show
    @course = Course.find(params[:id])
    @course = Course.includes(:coding_class, :trimester).find(params[:id])
    @students = @course.enrollments.includes(:student).map(&:student)
  end

  # GET /courses/new
  def new
    @course = Course.new 
    @coding_classes = CodingClass.all 
    @trimester = Trimester.all 
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
  

    respond_to do |format|
      if @course.save 
        format.html { redirect_to @course, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end 
    end 
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy!

    respond_to do |format|
      format.html { redirect_to courses_path, status: :see_other, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:coding_class_id, :trimester_id, :max_enrollment)
    end
end

    


