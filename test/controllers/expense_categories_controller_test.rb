# frozen_string_literal: true

require 'test_helper'

class ExpenseCategoriesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get expense_categories_index_url
    assert_response :success
  end

  test 'should get new' do
    get expense_categories_new_url
    assert_response :success
  end

  test 'should get create' do
    get expense_categories_create_url
    assert_response :success
  end

  test 'should get edit' do
    get expense_categories_edit_url
    assert_response :success
  end

  test 'should get update' do
    get expense_categories_update_url
    assert_response :success
  end
end
