require 'test_helper'

module Lit
  class ReferencesControllerTest < ActionController::TestCase
    setup do
      @reference = lit_references(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:references)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create reference" do
      assert_difference('Reference.count') do
        post :create, reference: { author: @reference.author, title: @reference.title }
      end

      assert_redirected_to reference_path(assigns(:reference))
    end

    test "should show reference" do
      get :show, id: @reference
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @reference
      assert_response :success
    end

    test "should update reference" do
      patch :update, id: @reference, reference: { author: @reference.author, title: @reference.title }
      assert_redirected_to reference_path(assigns(:reference))
    end

    test "should destroy reference" do
      assert_difference('Reference.count', -1) do
        delete :destroy, id: @reference
      end

      assert_redirected_to references_path
    end
  end
end
