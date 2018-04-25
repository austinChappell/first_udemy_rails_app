require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.new(name: "sports")
  end

  test "should get categories index" do
    get categories_path
    assert_response :success
  end

  test "should get new" do
    get new_category_path
    assert_response :success
  end

  test "should get show" do
    @category.save
    get category_path(@category)
    assert_response :success
  end

end