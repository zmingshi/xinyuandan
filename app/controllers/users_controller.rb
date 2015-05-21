class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  #finduser
  def finduser
  end

  # search user
  # POST /search
  def search
    @user = User.find_by_name(params[:name])
	respond_to do |format|
	if @user
      #format.html { redirect_to @user }
      format.html { render template: "users/adduser" }
	  #format.html { render json: { :user => @user } }
	  format.json { render json: { :user => @user } }
	else
      format.html { render json: { :error => "user does not exist" } }
	  format.json { render json: { :error => "user does not exist" } }
	end
  end
end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        #format.html { redirect_to @user, notice: "User #{@user.name} was successfully created." }
        #format.json { render action: 'show', status: :created, location: @user }
        format.html { render json: { :wish_items => [] , :user => @user } }
        format.json { render json: { :wish_items => [] , :user => @user } }
      else
        format.html { render action: 'new' }
        format.json { render json: { :error => 'SignUpFailed'} }
        #format.json { render json: {:} }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User #{@user.name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
	  require 'json'
	  params[:user] = JSON.parse params[:user] if params[:user].is_a?String
      params.require(:user).permit(:name, :address, :password, :password_confirmation)
    end
end
