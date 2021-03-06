require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "basic associations" do
    one = questions(:one)
    assert_kind_of Person, one.creator
    assert_kind_of Person, one.modified_by
    assert_kind_of Answer, one.answers.first
  end

end
