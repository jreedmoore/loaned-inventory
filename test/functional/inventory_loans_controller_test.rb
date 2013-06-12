require 'test_helper'

class InventoryLoansControllerTest < ActionController::TestCase
  setup do
    @inventory_loan = inventory_loans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_loans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_loan" do
    assert_difference('InventoryLoan.count') do
      post :create, inventory_loan: { loaned_date: @inventory_loan.loaned_date, returned_date: @inventory_loan.returned_date }
    end

    assert_redirected_to inventory_loan_path(assigns(:inventory_loan))
  end

  test "should show inventory_loan" do
    get :show, id: @inventory_loan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventory_loan
    assert_response :success
  end

  test "should update inventory_loan" do
    put :update, id: @inventory_loan, inventory_loan: { loaned_date: @inventory_loan.loaned_date, returned_date: @inventory_loan.returned_date }
    assert_redirected_to inventory_loan_path(assigns(:inventory_loan))
  end

  test "should destroy inventory_loan" do
    assert_difference('InventoryLoan.count', -1) do
      delete :destroy, id: @inventory_loan
    end

    assert_redirected_to inventory_loans_path
  end
end