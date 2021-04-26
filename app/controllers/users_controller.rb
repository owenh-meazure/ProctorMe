class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :set_college, :set_exam, only: [:enroll]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # POST /users
  # enrolls the user in the given exam if `exam_id` is provided
  # enrolls the user at the given college if `college_id` is provided
  # when an id param is passed, tries update an existing user instead of creating a new one
  def enroll
    @user =
      if params[:id]
        User.find(params[:id]).update(user_params)
      else
        User.new(user_params).save
      end

    if !exam_active?
      render json: "start_time must be between the exam's start and end times", status: :bad_request
    elsif !exam_belongs_to_college?
      render json: "exam must belong to the given college", status: :bad_request
    else
      render status: :ok
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_college
      @college = College.find(params[:college_id])
    end

    def set_exam
      @exam = Exam.find(params[:exam_id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(%I[
        id college_id exam_id first_name last_name phone_number start_time
      ])
    end

    # returns true when the associated exam belongs to the associated college
    def exam_belongs_to_college?
      @exam && @college&.exams.any? { |exam| exam.id == @exam.id }
    end

    # returns true when the start_time falls within the time window for of the exam
    def exam_active?
      return false unless @exam

      enroll_time = params[:start_time]&.to_time(:utc) || Time.zone.now
      after_start = !@exam.start_time || @exam.start_time <= enroll_time
      before_end = !@exam.end_time || enroll_time <= @exam.end_time

      after_start && before_end
    end
end
