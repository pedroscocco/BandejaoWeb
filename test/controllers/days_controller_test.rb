require 'test_helper'

class DaysControllerTest < ActionController::TestCase
  setup do
    @day = days(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:days)
  end

  test "should create day" do
    assert_difference('Day.count') do
      post :create, day: { date: @day.date, dishes: @day.dishes, menu_id: @day.menu_id, name: @day.name }
    end

    assert_response 201
  end

  test "should show day" do
    get :show, id: @day
    assert_response :success
  end

  test "should update day" do
    put :update, id: @day, day: { date: @day.date, dishes: @day.dishes, menu_id: @day.menu_id, name: @day.name }
    assert_response 204
  end

  test "should destroy day" do
    assert_difference('Day.count', -1) do
      delete :destroy, id: @day
    end

    assert_response 204
  end
end
