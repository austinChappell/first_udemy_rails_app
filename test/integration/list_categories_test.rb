require 'test_helper'

class ListCategoriesText < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "sports")
    @category2 = Category.create(name: "programming")
  end

  test "should show categories listing" do
    get categories_path
    assert_template 'categories/index'
    assert_select 'h1', text: @category.name
    assert_select 'h1', text: @category2.name
  end

end