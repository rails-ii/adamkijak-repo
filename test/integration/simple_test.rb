require "test_helper"

class ExampleTest < ActionController::IntegrationTest

  setup do
  end

  test "example" do
	visit '/'
    assert page.has_content?('Articles:')
  end

end
