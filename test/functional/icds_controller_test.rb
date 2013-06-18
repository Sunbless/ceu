require 'test_helper'

class IcdsControllerTest < ActionController::TestCase
  setup do
    @icd = icds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:icds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create icd" do
    assert_difference('Icd.count') do
      post :create, icd: { both: @icd.both, code: @icd.code, disease_bsn: @icd.disease_bsn, disease_eng: @icd.disease_eng, int: @icd.int }
    end

    assert_redirected_to icd_path(assigns(:icd))
  end

  test "should show icd" do
    get :show, id: @icd
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @icd
    assert_response :success
  end

  test "should update icd" do
    put :update, id: @icd, icd: { both: @icd.both, code: @icd.code, disease_bsn: @icd.disease_bsn, disease_eng: @icd.disease_eng, int: @icd.int }
    assert_redirected_to icd_path(assigns(:icd))
  end

  test "should destroy icd" do
    assert_difference('Icd.count', -1) do
      delete :destroy, id: @icd
    end

    assert_redirected_to icds_path
  end
end
