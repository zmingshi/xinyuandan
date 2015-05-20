require 'test_helper'

class WishItemsControllerTest < ActionController::TestCase
  setup do
    @wish_item = wish_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wish_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wish_item" do
    assert_difference('WishItem.count') do
      post :create, wish_item: { flag: @wish_item.flag, mark: @wish_item.mark, title: @wish_item.title, url: @wish_item.url, user_id: @wish_item.user_id }
    end

    assert_redirected_to wish_item_path(assigns(:wish_item))
  end

  test "should show wish_item" do
    get :show, id: @wish_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wish_item
    assert_response :success
  end

  test "should update wish_item" do
    patch :update, id: @wish_item, wish_item: { flag: @wish_item.flag, mark: @wish_item.mark, title: @wish_item.title, url: @wish_item.url, user_id: @wish_item.user_id }
    assert_redirected_to wish_item_path(assigns(:wish_item))
  end

  test "should destroy wish_item" do
    assert_difference('WishItem.count', -1) do
      delete :destroy, id: @wish_item
    end

    assert_redirected_to wish_items_path
  end
end
