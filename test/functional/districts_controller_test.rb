require 'test_helper'

class DistrictsControllerTest < ActionController::TestCase
  setup do
    @district = districts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:districts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create district" do
    assert_difference('District.count') do
      post :create, district: { abbr: @district.abbr, centar: @district.centar, code: @district.code, code_stat: @district.code_stat, entity: @district.entity, municipalities: @district.municipalities, name: @district.name, name_eng: @district.name_eng, population: @district.population }
    end

    assert_redirected_to district_path(assigns(:district))
  end

  test "should show district" do
    get :show, id: @district
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @district
    assert_response :success
  end

  test "should update district" do
    put :update, id: @district, district: { abbr: @district.abbr, centar: @district.centar, code: @district.code, code_stat: @district.code_stat, entity: @district.entity, municipalities: @district.municipalities, name: @district.name, name_eng: @district.name_eng, population: @district.population }
    assert_redirected_to district_path(assigns(:district))
  end

  test "should destroy district" do
    assert_difference('District.count', -1) do
      delete :destroy, id: @district
    end

    assert_redirected_to districts_path
  end
end
