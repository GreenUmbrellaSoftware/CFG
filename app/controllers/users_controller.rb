class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  layout false

  def index
    @users = User.all
  end

  # GET /users/1/edit
  def edit
    respond_to do |format|
      if @user
        @user.active = true
        @user.pending = false
        @user.save
      end
      format.json { render json: {:status => :ok}}
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user
        @user.active = false
        @user.pending = false
        @user.save
      end
      format.json { render json: {:status => :ok}}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end
end
