class User
  attr_accessor :id, :name, :role

  def initialize(id, name, role)
    @id = id
    @name = name
    @role = role
  end

  # Create a booking if the resource is available
  def create_booking(resource)
    raise "Invalid resource" if resource.nil?
  
    unless resource.available?
      raise "Resource '#{resource.name}' is not available"
    end
  
    resource.book!
  
    Booking.new(self, resource)
  end
end
