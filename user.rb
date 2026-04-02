class User
  attr_accessor :id, :name, :role

  def initialize(id, name, role)
    @id = id
    @name = name
    @role = role
  end

  # Create a booking if the resource is available
  def create_booking(resource)
    if resource.available?
      booking = Booking.new(self, resource)
      resource.book!
      booking
    else
      raise "Resource is not available"
    end
  end
end

