require_relative 'errors'

class Booking
  VALID_STATUSES = ["active", "cancelled"]
  @@all_bookings = []

  attr_reader :user, :resource, :created_at
  attr_accessor :status

  def initialize(user:, resource:)
    raise InvalidActionError, 'User is required' unless user
    raise InvalidActionError, 'Resource is required' unless resource
    raise ResourceUnavailableError, "Cannot book '#{resource.name}', it is already booked." unless resource.available?

    @user = user
    @resource = resource
    @status = 'active'
    @created_at = Time.now

    resource.assign_booking(self)
    @@all_bookings << self
  end

  def self.active_bookings
    @@all_bookings.select(&:active?)
  end

  def cancel
    raise InvalidActionError, 'Booking already cancelled.' if status == 'cancelled'

    @status = 'cancelled'
    resource.release!
  end

  def active?
    status == 'active'
  end

  def cancelled?
    status == 'cancelled'
  end

  def to_s
    "Booking(user: #{user.name}, resource: #{resource.name}, status: #{status})"
  end
end
