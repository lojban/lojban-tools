require 'test_helper'

class JboControllerTest < ActionController::TestCase

  self.display_invalid_content = true
#  self.auto_validate = true
  assert_valid_css_files 'application'

  def test_index
    get :index
    assert_response :success
    assert_valid_markup
  end

end
