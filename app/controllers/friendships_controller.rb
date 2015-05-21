class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update, :destroy]
  before_action :authorized_user, :only => :destroy

  # GET /friendships
  # GET /friendships.json
  def index
    @user = current_user
    @friendships = @user.friendships
    @inverse_friendships = @user.inverse_friendships

	friend_id_list = []
	@friendships.each do |friendship|
	  friend_id_list << friendship.friend_id
	end
    @inverse_friendships.each do |friendship|
	  friend_id_list << friendship.user_id
	end
	friend_id_list = friend_id_list.uniq

	@friends_list = User.select('id, name').find(friend_id_list)
    respond_to do |format|
	  if @friendships
	    format.html 
		format.json { render json: @friends_list }
	  end
	end
  end

  def index_bak
    @user = current_user
    @friends = @user.friends
    @inverse_friends = @user.inverse_friends

	friend_id_list = []
	@friends_list = []
	@friends.each do |friend|
	  @friends_list << friend
	end
    @inverse_friends.each do |friend|
	  @friends_list << friend
	end
	@friends_list = @friends_list.uniq

    respond_to do |format|
	  if @friends_list
	    format.html 
		format.json { render json: @friends_list }
	  end
	end
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
  end

  # GET /friendships/new
  def new
    @friendship = Friendship.new
  end

  # GET /friendships/1/edit
  def edit
  end

  # POST /friendships
  # POST /friendships.json
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])  
    respond_to do |format|
      if @friendship.save
	    #redirect_to action: 'index'
        format.html { redirect_to user_friendships_url(:user_id => current_user.id) }
        format.json { render json: @friendship }
      else
        format.html { render json: {:error => 'AddFriendFailed'} }
        format.json { render json: {:error => 'AddFriendFailed'} }
      end
    end
  end

  # PATCH/PUT /friendships/1
  # PATCH/PUT /friendships/1.json
  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to user_friendships_url(:user_id => current_user.id) }
      format.json { head :no_content }
    end
  end

  private
    def authorized_user
	  @friendship = current_user.friendships.find_by_id(params[:id])
	  redirect_to users_path if @friendship.nil?
	end

    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id)
    end
end
