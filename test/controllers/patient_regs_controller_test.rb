require "test_helper"

class PatientRegsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get patient_regs_new_url
    assert_response :success
  end

  test "should get create" do
    get patient_regs_create_url
    assert_response :success
  end

  test "should get show" do
    get patient_regs_show_url
    assert_response :success
  end
end
