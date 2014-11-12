require 'test_helper'

class ProduktesControllerTest < ActionController::TestCase
  setup do
    @produkte = produktes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:produktes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create produkte" do
    assert_difference('Produkte.count') do
      post :create, produkte: { beschreibung: @produkte.beschreibung, datumbis: @produkte.datumbis, datumvon: @produkte.datumvon, name: @produkte.name, preis: @produkte.preis, stueckzahl: @produkte.stueckzahl }
    end

    assert_redirected_to produkte_path(assigns(:produkte))
  end

  test "should show produkte" do
    get :show, id: @produkte
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @produkte
    assert_response :success
  end

  test "should update produkte" do
    patch :update, id: @produkte, produkte: { beschreibung: @produkte.beschreibung, datumbis: @produkte.datumbis, datumvon: @produkte.datumvon, name: @produkte.name, preis: @produkte.preis, stueckzahl: @produkte.stueckzahl }
    assert_redirected_to produkte_path(assigns(:produkte))
  end

  test "should destroy produkte" do
    assert_difference('Produkte.count', -1) do
      delete :destroy, id: @produkte
    end

    assert_redirected_to produktes_path
  end
end
