require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "Sports")
    @category2 = Category.create(name: "Travel")
    @admin_user = User.create(name: "admin",email: "admin@admin.com", password: "admin", admin: true)
    sign_in_as(@admin_user)
  end
  test "Create and List categories" do
   
    get "/categories"
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end
