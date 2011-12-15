require 'test_helper'

class RegisterTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Register.new.valid?
  end
end
