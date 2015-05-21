class WishItemsController < ApplicationController
  before_action :set_wish_item, only: [:show, :edit, :update, :destroy]
  before_action :authorized_user, :only => :destroy

  # GET /wish_items
  # GET /wish_items.json
  def item
    @user = User.find(params[:id])
	@wish_items = @user.wish_items
	respond_to do |format|
	  if @wish_items
	    format.html { render action: 'index' }
		format.json { render json: @wish_items }
	  end
	end
  end
  
  # GET /wish_items
  # GET /wish_items.json
  # GET wish_items for current_user
  def index
    params[:id] = session[:user_id]
    item
  end

  # GET /wish_items/1
  # GET /wish_items/1.json
  def show
  end

  # GET /wish_items/new
  def new
    @wish_item = WishItem.new
  end

  # GET /wish_items/1/edit
  def edit
  end

  # POST /wish_items
  # POST /wish_items.json
  def create
	@wish_item = current_user.wish_items.build(wish_item_params)
    #@wish_item = WishItem.new(wish_item_params)

    respond_to do |format|
      if @wish_item.save
        format.html { redirect_to @wish_item, notice: 'Wish item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @wish_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @wish_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wish_items/1
  # PATCH/PUT /wish_items/1.json
  def update
    respond_to do |format|
      if @wish_item.update(wish_item_params)
        format.html { redirect_to @wish_item, notice: 'Wish item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @wish_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wish_items/1
  # DELETE /wish_items/1.json
  def destroy
    @wish_item.destroy
    respond_to do |format|
      format.html { redirect_to wish_items_url }
      format.json { head :no_content }
    end
  end

  private
    def authorized_user
	  @wish_item = current_user.wish_items.find_by_id(params[:id])
	  redirect_to users_path if @wish_item.nil?
	end
    # Use callbacks to share common setup or constraints between actions.
    def set_wish_item
      @wish_item = WishItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wish_item_params
      params.require(:wish_item).permit(:title, :url, :mark, :flag, :user_id)
    end
end
