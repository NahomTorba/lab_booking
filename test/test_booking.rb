require "minitest/autorun"
require_relative "../user"
require_relative "../resource"
require_relative "../booking"
require_relative "../errors"

class BookingTest < Minitest::Test
  def setup
    @user = User.new(id: 1, name: "Test", role: "tester")
    @resource = Resource.new(id: 1, name: "Machine", category: "equipment")
  end

  def test_booking_an_available_resource
    booking = @user.create_booking(@resource)

    assert_equal "active", booking.status
    assert_equal @resource, booking.resource
    assert_equal @user, booking.user
    refute @resource.available?
  end

  def test_booking_unavailable_resource
    @user.create_booking(@resource)

    assert_raises(ResourceUnavailableError) do
      @user.create_booking(@resource)
    end
  end

  def test_cancel_booking
    booking = @user.create_booking(@resource)
    booking.cancel

    assert_equal "cancelled", booking.status
  end

  def test_cancel_makes_resource_available
    booking = @user.create_booking(@resource)
    booking.cancel

    assert @resource.available?
  end
end
