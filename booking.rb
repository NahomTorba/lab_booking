require_relative 'resource'
require 'time'

class Booking
  VALID_STATUSES = ["active", "cancelled"]

  attr_reader :user, :resource, :created_at
  attr_accessor :status

  def initialize(user, resource)
    raise "Cannot book '#{resource.name}', it is already booked." unless resource.available?

    @user = user
    @resource = resource
    @status = "active"
    @created_at = Time.now
  end

  def cancel
    raise "Booking already cancelled." if status == "cancelled"

    @status = "cancelled"
    resource.release!
  end

  def to_s
    "Booking(user: #{user.name}, resource: #{resource.name}, status: #{status})"
  end
end
