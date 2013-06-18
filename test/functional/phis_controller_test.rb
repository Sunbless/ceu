require 'test_helper'

class PhisControllerTest < ActionController::TestCase
  setup do
    @phi = phis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phi" do
    assert_difference('Phi.count') do
      post :create, phi: { abbrev: @phi.abbrev, address: @phi.address, district_id: @phi.district_id, email: @phi.email, epidemiologist: @phi.epidemiologist, fax: @phi.fax, full_bsn: @phi.full_bsn, full_eng: @phi.full_eng, mail_no: @phi.mail_no, municipality_id: @phi.municipality_id, phone: @phi.phone, post: @phi.post }
    end

    assert_redirected_to phi_path(assigns(:phi))
  end

  test "should show phi" do
    get :show, id: @phi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @phi
    assert_response :success
  end

  test "should update phi" do
    put :update, id: @phi, phi: { abbrev: @phi.abbrev, address: @phi.address, district_id: @phi.district_id, email: @phi.email, epidemiologist: @phi.epidemiologist, fax: @phi.fax, full_bsn: @phi.full_bsn, full_eng: @phi.full_eng, mail_no: @phi.mail_no, municipality_id: @phi.municipality_id, phone: @phi.phone, post: @phi.post }
    assert_redirected_to phi_path(assigns(:phi))
  end

  test "should destroy phi" do
    assert_difference('Phi.count', -1) do
      delete :destroy, id: @phi
    end

    assert_redirected_to phis_path
  end
end
