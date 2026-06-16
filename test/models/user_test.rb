# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "nameがあればnameを返す" do
    user = users(:one)

    assert_equal 'namae', user.name_or_email
  end

  test "nameがなければemailを返す" do
    user = users(:two)

    assert_equal 'two@example.com', user.name_or_email
  end
end
