require 'test_helper'

class HesControllerTest < ActionController::TestCase
  setup do
    @he = hes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create he" do
    assert_difference('He.count') do
      post :create, he: { center_id: @he.center_id, chief_id: @he.chief_id, code: @he.code, name: @he.name, nurse_id: @he.nurse_id }
    end

    assert_redirected_to he_path(assigns(:he))
  end

  test "should show he" do
    get :show, id: @he
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @he
    assert_response :success
  end

  test "should update he" do
    put :update, id: @he, he: { center_id: @he.center_id, chief_id: @he.chief_id, code: @he.code, name: @he.name, nurse_id: @he.nurse_id }
    assert_redirected_to he_path(assigns(:he))
  end

  test "should destroy he" do
    assert_difference('He.count', -1) do
      delete :destroy, id: @he
    end

    assert_redirected_to hes_path
  end
end
