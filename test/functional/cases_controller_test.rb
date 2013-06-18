require 'test_helper'

class CasesControllerTest < ActionController::TestCase
  setup do
    @case = cases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create case" do
    assert_difference('Case.count') do
      post :create, case: { age: @case.age, agent_id: @case.agent_id, comment: @case.comment, date_death: @case.date_death, date_entry: @case.date_entry, date_lab: @case.date_lab, date_of_birth: @case.date_of_birth, date_of_dg: @case.date_of_dg, date_report: @case.date_report, dg_syndrom: @case.dg_syndrom, district_id: @case.district_id, he_id: @case.he_id, jmbg: @case.jmbg, labconfirmed: @case.labconfirmed, laboratory_id: @case.laboratory_id, operator_id: @case.operator_id, patient_name: @case.patient_name, patient_surname: @case.patient_surname, phi_id: @case.phi_id, protocol: @case.protocol, sex: @case.sex, user_id: @case.user_id, vaccin: @case.vaccin }
    end

    assert_redirected_to case_path(assigns(:case))
  end

  test "should show case" do
    get :show, id: @case
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @case
    assert_response :success
  end

  test "should update case" do
    put :update, id: @case, case: { age: @case.age, agent_id: @case.agent_id, comment: @case.comment, date_death: @case.date_death, date_entry: @case.date_entry, date_lab: @case.date_lab, date_of_birth: @case.date_of_birth, date_of_dg: @case.date_of_dg, date_report: @case.date_report, dg_syndrom: @case.dg_syndrom, district_id: @case.district_id, he_id: @case.he_id, jmbg: @case.jmbg, labconfirmed: @case.labconfirmed, laboratory_id: @case.laboratory_id, operator_id: @case.operator_id, patient_name: @case.patient_name, patient_surname: @case.patient_surname, phi_id: @case.phi_id, protocol: @case.protocol, sex: @case.sex, user_id: @case.user_id, vaccin: @case.vaccin }
    assert_redirected_to case_path(assigns(:case))
  end

  test "should destroy case" do
    assert_difference('Case.count', -1) do
      delete :destroy, id: @case
    end

    assert_redirected_to cases_path
  end
end
