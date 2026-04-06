require_relative 'errors'
require_relative 'booking'

class User
  attr_reader :id, :name, :role

  def initialize(id:, name:, role:)
    @id = id
    @name = name
    @role = role
  end

  # Create a booking if the resource is available
  def create_booking(resource)
    raise InvalidActionError, "Invalid resource" if resource.nil?
    Booking.new(user: self, resource: resource)
  end

  def to_s
    "User(id: #{id}, name: #{name}, role: #{role})"
  end
end
