require 'test_helper'
class User < ApplicationRecord
    def setup
        @user = User.new(name: "Example User", email: "user@example.com")
    end
    test "should be valid" do
        assert @user.valid?
    end
end
