require "minitest/autorun"
require_relative "../user"
require_relative "../resource"

class ResourceTest < Minitest::Test
  def setup
    @resource = Resource.new(id: 1, name: "microscope", category: "biology")
    @user = User.new(id: 1, name: "Gentalaw", role: "scientist")
  end

  def test_resource_is_available_by_default
    assert @resource.available?
  end

  def test_resource_becomes_unavailable_when_booked
    booking = @user.create_booking(@resource)

    refute @resource.available?
    assert_equal booking, @resource.current_booking
  end

  def test_resource_becomes_available_after_cancel
    booking = @user.create_booking(@resource)
    booking.cancel

    assert @resource.available?
    assert_nil @resource.current_booking
  end
end
