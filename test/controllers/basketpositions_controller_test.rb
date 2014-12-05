require 'test_helper'

class BasketpositionsControllerTest < ActionController::TestCase
  setup do
    @basketposition = basketpositions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:basketpositions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create basketposition" do
    assert_difference('Basketposition.count') do
      post :create, basketposition: { how_many: @basketposition.how_many, product_id: @basketposition.product_id, user_id: @basketposition.user_id }
    end

    assert_redirected_to basketposition_path(assigns(:basketposition))
  end

  test "should show basketposition" do
    get :show, id: @basketposition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @basketposition
    assert_response :success
  end

  test "should update basketposition" do
    patch :update, id: @basketposition, basketposition: { how_many: @basketposition.how_many, product_id: @basketposition.product_id, user_id: @basketposition.user_id }
    assert_redirected_to basketposition_path(assigns(:basketposition))
  end

  test "should destroy basketposition" do
    assert_difference('Basketposition.count', -1) do
      delete :destroy, id: @basketposition
    end

    assert_redirected_to basketpositions_path
  end
end
