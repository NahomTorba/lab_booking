require "minitest/autorun"
require_relative "../user"
require_relative "../resource"
require_relative "../booking"
require_relative "../errors"

class UserTest < Minitest::Test
  def setup
    @user = User.new(id: 1, name: "Abuchu", role: "admin")
    @resource = Resource.new(id: 1, name: "3D Printer", category: "modelling")
  end

  def test_create_booking
    booking = @user.create_booking(@resource)

    assert_instance_of Booking, booking
    assert_equal "active", booking.status
  end

  def test_create_booking_with_nil
    assert_raises(InvalidActionError) do
      @user.create_booking(nil)
    end
  end
end
